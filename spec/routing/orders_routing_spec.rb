require "rails_helper"

RSpec.describe OrdersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/orders.json").to route_to("orders#index", format: 'json')
    end

    it "routes to #show" do
      expect(:get => "/orders/1.json").to route_to("orders#show", format: 'json', uid: '1')
    end

    it "routes to #create" do
      expect(:post => "/orders.json").to route_to("orders#create", format: 'json')
    end

  end
end
