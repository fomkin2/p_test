class PagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_page, only: [:show, :edit, :update]

  # GET /
  def index
    banners = BannerPosition.where(description: '首页轮播')
    if banners.present?
      carousel_banner_position = banners.first
      @carousel_banners = Banner.where(banner_position_id: carousel_banner_position.id)
      @carousel_banner_width = carousel_banner_position.size.split('x').first
      @carousel_banner_height = carousel_banner_position.size.split('x').last
    end
  end

  def contact
    @message = Message.new
  end

  # GET /pages/1/edit
  def edit
  end

  def update
    @page.update(page_params)
    redirect_to action: :show
  end

  def error404
    render status: :not_found
  end

  private

    def set_page
      @page = Page.find_by_uid(params[:uid])
      not_found if @page.blank?
    end

    def page_params
      params.require(:page).permit(:content)
    end

end
