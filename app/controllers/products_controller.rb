class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html

  layout :resolve_layout

  def index
    @products = Product.all.order('ordering desc')
    respond_with(@products)
  end

  def list
    @products = Product.where(published: true).order('ordering desc')
    respond_with(@products)
  end

  def show
    @cart = Cart.new number: 1
    if @product.blank?
      render :file => "/pages/error404", :status => :not_found
      return
    end
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to "/products", notice: 'product created'
      return
    end
    render 'new'
  end

  def update
    if @product.update(product_params)
      redirect_to "/products", notice: 'product updated'
      return
    end
    reder 'edit'
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  private

    def resolve_layout
      case action_name
      when "index", "new", "edit", 'create', 'update'
        "admin"
      else
        "application"
      end
    end

    def set_product
      if params[:title].present?
        @product = Product.where(title: params[:title]).first
        return
      end
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :introduction, :description, :information, :published, :link, :price)
    end
end
