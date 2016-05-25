class CartsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts.json
  def index
    @carts = Cart.where(user: current_user)
  end

  # POST /carts.json
  def create
    cart = Cart.new(cart_params)
    if cart[:product_id].blank?
      render text: 'bad request', :status => :bad_request
      return
    end
    product = Product.where(id: cart[:product_id]).first
    if product.blank?
      render text: 'product not exist', :status => :bad_request
      return
    end
    cart[:number] = 1 if cart[:number].blank?
    if cart = Cart.add(product: product, user: current_user, number: cart[:number])
      render json: cart, :status => :created
      return
    end
    render text: 'bad request', :status => :bad_request
  end

  # GET /carts.json
  def minus
    respond_to do |format|
      format.json do
        cart = Cart.find params[:id]
        return unless auth_user cart
        if cart.reduce
          render json: cart, status: :accepted
          return
        end
        render text: 'can not minus', status: :bad_request
      end
    end
  end

  # GET /carts.json
  def plus
    respond_to do |format|
      format.json do
        cart = Cart.find params[:id]
        return unless auth_user cart
        if cart.increase
          render json: cart, status: :accepted
          return
        end
      end
    end
  end

  # DELETE /carts/1.json
  def destroy
    return unless auth_user @cart
    @cart.destroy
    head :no_content
  end

  private
    def auth_user cart
      if cart.user != current_user
        render text: 'forbidden', :status => :forbidden
        return false
      end
      true
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:product_id, :number)
    end
end
