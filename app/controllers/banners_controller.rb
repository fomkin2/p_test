class BannersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource
  before_action :set_banner, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  respond_to :html

  # GET /banners
  def index
    @banner_positions = BannerPosition.all
    @banner_position = BannerPosition.find params[:banner_position_id]
    @banners = Banner.all
    @banners = @banners.where(banner_position_id: @banner_position.id)
    @banners = @banners.order('ordering desc')
  end

  # GET /banners/new
  def new
    banner_position = BannerPosition.find params[:banner_position_id]
    @banner = Banner.new
    @banner.banner_position_id = banner_position.id
  end

  # GET /banners/1/edit
  def edit
  end

  # POST /banners
  def create
    @banner = Banner.new(banner_params)

    if @banner.save
      redirect_to({ action: :index, banner_position_id: @banner.banner_position_id }, notice: 'Banner was successfully created.')
    else
      render :new
    end
  end

  # PATCH/PUT /banners/1
  def update
    if @banner.update(banner_params)
      redirect_to({ action: :index, banner_position_id: @banner.banner_position_id }, notice: 'Banner was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /banners/1
  def destroy
    @banner.destroy
    redirect_to request.referer, notice: 'Banner was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banner_params
      params.require(:banner).permit(:image, :url, :ordering, :banner_position_id, :new_window)
    end
end
