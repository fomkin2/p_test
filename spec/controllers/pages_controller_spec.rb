require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views

  describe "GET #index" do
    it "should response 200 even seed hasn't loaded" do
      get :index
      expect(response.status).to eq(200)
    end

    it "should response 200 even no banner data" do
      BannerPosition.create(description: '首页轮播', size: '940x300')
      BannerPosition.create(description: '首页滑动', size: '140x138')
      get :index
      expect(response.status).to eq(200)
    end
  end

end
