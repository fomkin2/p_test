class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_order, only: [:show]
  before_action :check_cart, only: [:create]

  # GET /orders.json
  def index
    @orders = Order.where(user: current_user).order('created_at desc')
  end

  # GET /orders/1.json
  def show
  end

  # POST /orders.json
  def create
    order = Order.place_order user: current_user, comment: params[:comment]
    render text: {
      uid: order.uid,
      price: order.price,
      status: order.status,
      created_at: order.created_at,
    }.to_json, status: :created
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      if params[:uid].blank?
        render text: 'uid is required', status: :bad_request
        return false
      end
      @order = Order.find_by uid: params[:uid]
      if @order.user_id != current_user.id
        render :status => :forbidden, :text => "Forbidden"
        return false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order]
    end

    def check_cart
      if Cart.empty_cart? current_user
        render text: 'carts is empty', status: :bad_request
        return
      end
    end
end
