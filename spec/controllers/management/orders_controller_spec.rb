require 'rails_helper'

RSpec.describe Management::OrdersController, type: :controller do

  before(:example) do
    @user = create :user
    @user.confirm
    @admin = create :admin
    sign_in :admin, @admin
  end

  let!(:order) {
    product = create :product
    create :cart, user: @user, product: product, number: 1
    Management::Order.find(
      Order.place_order(user: @user, comment: "{ phone: '18018018018' }").id
    )
  }

  describe "GET #index" do
    it "assigns all management_orders as @management_orders" do
      get :index
      expect(assigns(:management_orders)).to eq([order])
    end
  end

  describe "GET #show" do
    it "assigns the requested management_order as @management_order" do
      get :show, {:id => order.to_param}
      expect(assigns(:management_order)).to eq(order)
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested management_order" do
        patch :update, {
          :id => order.to_param,
          :order => {status: 'CANCELED', comment: '没付钱'}
        }
        order.reload
        expect(order.status).to eq('CANCELED')
      end

      it "assigns the requested management_order as @management_order" do
        patch :update, {
          :id => order.to_param,
          :order => {status: 'CANCELED', comment: '没付钱'}
        }
        expect(assigns(:management_order)).to eq(order)
      end

      it "redirects to the management_order" do
        patch :update, {
          :id => order.to_param,
          :order => {status: 'CANCELED', comment: '没付钱'}
        }
        expect(response).to redirect_to(order)
      end
    end

    context "with invalid params" do
      it "redirects to the management_order" do
        expect {
          patch :update, {
            :id => order.to_param,
            :order => {status: 'CANCELED', comment: ''}
          }
        }.to raise_error('comment is required')
      end
    end
  end

end
