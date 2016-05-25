require 'rails_helper'

RSpec.describe "Orders", type: :request do
  before(:example) do
    sign_in_as_a_valid_user
    create :cart, user: @user
    @order = Order.place_order user: @user
  end

  describe "GET /orders" do
    it "response 200 if user signed in" do
      get '/orders'
      expect(response).to have_http_status(200)
    end

    it "response 401 if user haven't signed in" do
      delete_via_redirect destroy_user_session_path
      get '/orders'
      expect(response).to have_http_status(401)
    end

    it "response as json" do
      get '/orders.json'
      expect(JSON.parse(response.body)[0].keys).to match_array(%w(
        uid price status created_at url payment_url
      ))
    end

    it "only current users's order" do
      other_user = create :user
      create :cart, user: other_user
      order = Order.place_order user: other_user
      expect(Order.all.count).to eq(2)
      get '/orders.json'
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'GET /orders/:uid' do
    it "response 200 if user signed in" do
      get "/orders/#{@order.uid}"
      expect(response).to have_http_status(200)
    end

    it "response 401 if user haven't signed in" do
      delete_via_redirect destroy_user_session_path
      get "/orders/#{@order.uid}"
      expect(response).to have_http_status(401)
    end

    it "response as json" do
      get "/orders/#{@order.uid}.json"
      expect(JSON.parse(response.body).keys).to match_array(%w(
        uid price status created_at payment_url logs products
      ))
    end

    it "can not get other user's order" do
      other_user = create :user
      create :cart, user: other_user
      order = Order.place_order user: other_user
      get "/orders/#{order.uid}.json"
      expect(response).to have_http_status(403)
      expect(response.body).to eq('Forbidden')
    end
  end

  describe 'POST /orders' do
    before do
      create :cart, user: @user
    end

    it "response 201 if user signed in" do
      post '/orders.json', comment: 'my comment'
      expect(response).to have_http_status(201)
    end

    it "response 401 if user haven't signed in" do
      delete_via_redirect destroy_user_session_path
      post '/orders.json', comment: 'my comment'
      expect(response).to have_http_status(401)
    end

    it 'place order' do
      expect {
        post '/orders.json', comment: 'my comment'
      }.to change { Order.count }.by(1)
      expect(Order.last.status).to eq('CREATED')
      expect(Order.last.orders_logs.last.comment).to eq('my comment')
    end

    it 'response with json' do
      post '/orders.json', comment: 'my comment'
      expect(JSON.parse(response.body).keys).to match_array(%w(
        uid price status created_at
      ))
    end

    it 'redirect when cart is empty' do
      Cart.delete_all
      post '/orders', comment: 'my comment'
      expect(response).to have_http_status(400)
      expect(response.body).to eq('carts is empty')
    end
  end
end
