require "rails_helper"

RSpec.describe CartsController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/carts.json").to route_to("carts#create", format: 'json')
    end

    it "routes to #index" do
      expect(:get => "/carts.json").to route_to("carts#index", format: 'json')
    end

    it "routes to #destroy" do
      expect(:delete => "/carts/1.json").to route_to("carts#destroy", id: '1', format: 'json')
    end

    it "routes to #minus" do
      expect(:patch => "/carts/minus/1.json").to route_to("carts#minus", id: '1', format: 'json')
    end

    it "routes to #plus" do
      expect(:patch => "/carts/plus/1.json").to route_to("carts#plus", id: '1', format: 'json')
    end

  end
end
