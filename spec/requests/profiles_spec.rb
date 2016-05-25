require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /profiles" do
    it "user did not sign in whom can not view profile" do
      get '/profile'
      expect(response).to have_http_status(302)
    end
    it "user signed in whom can view profile" do
      get '/profile/edit'
      expect(response).to have_http_status(302)
    end
  end
end
