class OrdersNotifyController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action do
    @notify_params = params.except(*request.path_parameters.keys)
    if !verify?
      render text: "error", status: 400
      return false
    end
  end

  def return
    if status_changed_to != 'PAID' || !set_order_to('PAID')
      return render text: "error", status: 400
    end
    redirect_to "/#/orders/#{@notify_params[:out_trade_no]}"
  end

  def notify
    if @notify_params[:trade_status] == 'WAIT_BUYER_PAY'
      alipay_trade_no = @notify_params[:trade_no]
      order = Management::Order.find_by(
        uid: @notify_params[:out_trade_no]
      )
      order.orders_logs.create status: order.status, comment: '支付宝订单已生成'
    end
    if status_changed_to
      return render text: "error", status: 400 unless set_order_to(status_changed_to)
    end
    render text: "success"
  end

  private

  def status_changed_to
    case @notify_params[:trade_status]
    when 'WAIT_BUYER_CONFIRM_GOODS'
      return 'DELIVERED'
    when 'WAIT_SELLER_SEND_GOODS'
      return 'PAID'
    end
    false
  end

  def verify?
    Alipay::Notify.verify?(@notify_params)
  end

  def set_order_to status
    alipay_trade_no = @notify_params[:trade_no]
    order = Management::Order.find_by(
      uid: @notify_params[:out_trade_no]
    )
    return true if order.status == status
    comment = {partner: 'ALIPAY'}
    if status == 'PAID'
      return false unless order.update alipay_trade_no: alipay_trade_no
      comment.merge!({
        name:     @notify_params[:receive_name],
        mobile:   @notify_params[:receive_mobile],
        phone:    @notify_params[:receive_phone],
        address:  @notify_params[:receive_address]
      })
    end
    order.set_status status, nil, JSON.generate(comment)
  end

end
