class ProductsImagesController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource
  before_action :set_products_image, only: [:show, :edit, :update, :destroy]

  layout 'admin'
  respond_to :html

  def index
    @product = Product.find params[:product_id]
    @products_images = ProductsImage.where(product_id: params[:product_id]).order('ordering desc')
    respond_with(@products_images)
  end

  def new
    @product = Product.find params[:product_id]
    @products_image = ProductsImage.new
    @products_image.product_id = params[:product_id]
    respond_with(@products_image)
  end

  def edit
    @product = Product.find @products_image.product_id
  end

  def create
    @products_image = ProductsImage.new(products_image_params)
    if @products_image.save
      redirect_to "/products_images?product_id=#{@products_image.product_id}", notice: 'product image created'
      return
    end
    render 'new'
  end

  def update
    if @products_image.update(products_image_params)
      redirect_to "/products_images?product_id=#{@products_image.product_id}", notice: 'product image updated'
      return
    end
    render 'edit'
  end

  def destroy
    @products_image.destroy
    redirect_to "/products_images?product_id=#{@products_image.product_id}", notice: 'product image deleted'
  end

  private
    def set_products_image
      @products_image = ProductsImage.find(params[:id])
    end

    def products_image_params
      params.require(:products_image).permit(:product_id, :ordering, :file)
    end
end
