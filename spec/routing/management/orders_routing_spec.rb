require "rails_helper"

RSpec.describe Management::OrdersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/management/orders").to route_to("management/orders#index")
    end

    it "routes to #show" do
      expect(:get => "/management/orders/1").to route_to("management/orders#show", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/management/orders/1").to route_to("management/orders#update", :id => "1")
    end

  end
end
