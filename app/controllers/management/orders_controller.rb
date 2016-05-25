class Management::OrdersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource
  before_action :set_management_order, only: [:show, :update]
  layout 'management'

  # GET /management/orders.json
  def index
    @management_orders = Management::Order.all.order('created_at desc')
    @management_orders = @management_orders.where(
      "uid like '%#{params[:uid]}%'"
    ) if params[:uid].present?
    if params[:status].present?
      new_list = []
      @management_orders.each do |o|
        new_list.push o if o.status == params[:status]
      end
      return @management_orders = new_list
    end
  end

  # GET /management/orders/1.json
  def show
    @support_status = Management::Order.support_status(
      @management_order.status
    )
    @can_edit_price = can_edit_price @management_order
  end

  # PATCH/PUT /management/orders/1
  # PATCH/PUT /management/orders/1.json
  def update
    p = management_order_params
    if p[:price].present?
      if !can_edit_price @management_order
        redirect_to @management_order, notice: '淘宝订单已生成，订单价格无法更新。'
      end
      if @management_order.update_price p[:price].to_i, current_admin.id, p[:comment]
        redirect_to @management_order, notice: '订单价格已更新'
        return
      end
      raise 'update price failed'
    end
    if @management_order.set_status p[:status], current_admin.id, p[:comment]
      if p[:status] == 'DELIVERED'
        doc = Nokogiri::XML(Alipay::Service.send_goods_confirm_by_platform(
          trade_no: @management_order.alipay_trade_no,
          logistics_name: "useless",
          transport_type: 'DIRECT'
        ))
        if doc.xpath('//alipay/is_success').children.first.to_s != 'T'
          raise 'can not set order to \
                 "send_goods_confirm_by_platform" on alipay'
        end
      end
      redirect_to @management_order, notice: '订单状态已更新'
    else
      redirect_to @management_order, alert: '订单状态更新失败'
    end
  end

  private
    def can_edit_price order
      !order.orders_logs.where(comment: '支付宝订单已生成').present?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_management_order
      @management_order = Management::Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def management_order_params
      params.require(:order).permit(:id, :status, :comment, :price)
    end
end
