class ImagesController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource
  before_action :set_image, only: [:show, :edit, :destroy]

  layout 'admin'

  respond_to :html

  def index
    @images = Image.all
    respond_with(@images)
  end

  def new
    @image = Image.new
    respond_with(@image)
  end

  def create
    @image = Image.new(image_params)
    @image.save
    redirect_to action: 'index'
  end

  def destroy
    @image.destroy
    redirect_to action: 'index'
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:file)
    end
end
