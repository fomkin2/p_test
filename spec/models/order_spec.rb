require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:product100) { create :product, price: 100 }
  let(:product50) { create :product, price: 50 }
  let(:user) { create :user }

  before(:example) do
    @cart100 = create :cart, user: user, product: product100, number: 10
    @cart50  = create :cart, user: user, product: product50, number: 5
    @order   = Order.place_order user: user, comment: 'phone: 180180180180'
  end

  describe 'status' do
    it 'CREATED' do
      expect(@order.status).to eq('CREATED')
    end

    it 'PAID' do
      @order.orders_logs.create status: 'PAID', comment: 'none'
      expect(@order.status).to eq('PAID')
    end
  end

  describe 'place_order' do
    it 'order uid' do
      @order.update_attribute('created_at', DateTime.now - 1.hour)
      for i in 1..10 do
        create :cart, user: user, product: product100, number: 10
        order = Order.place_order user: user
        order.reload
        expect(order.uid).to eq(
          'T' + order.created_at.strftime('%y%m%d%H') + i.to_s.rjust(4, '0')
        )
      end
    end

    it 'can not place order when cart is empty' do
      Cart.where(user: user).delete_all
      expect(Order.place_order user: user).to eq(false)
    end

    it 'product number' do
      expect(@order.orders_products.count).to eq(2)
    end

    it 'product ids' do
      expect(@order.orders_products.map { |p| p.product_id }).to match_array(
        [product50.id, product100.id]
      )
    end

    it 'product price' do
      expect(@order.orders_products.map { |p| p.price }).to match_array(
        [product50.price, product100.price]
      )
    end

    it 'product number' do
      expect(@order.orders_products.map { |p| p.number }).to match_array(
        [@cart100.number, @cart50.number]
      )
    end

    it 'sum the price' do
      expect(@order.price).to eq(100 * 10 + 50 * 5)
    end

    it 'empty cart' do
      expect(Cart.where(user: user).count).to eq(0)
    end

    it 'order status created' do
      expect(@order.status).to eq('CREATED')
    end

    it 'order with comment' do
      expect(@order.orders_logs.last.comment).to eq('phone: 180180180180')
    end
  end

  describe 'request_after_sale' do
    it 'request_after_sale a PAID order' do
      @order.orders_logs.order('created_at').last.update_attribute(
        :status, 'PAID'
      )
      @order.request_after_sale '没收到货'
      expect(@order.status).to eq('AFTER_SALE_REQUESTED')
    end

    it 'request_after_sale a DELIVERED order' do
      @order.orders_logs.order('created_at').last.update_attribute(
        :status, 'DELIVERED'
      )
      @order.request_after_sale '没收到货'
      expect(@order.status).to eq('AFTER_SALE_REQUESTED')
    end

    it 'raise error if without comment' do
      expect { @order.request_after_sale '' }.to raise_error(
        RuntimeError, "comment is required"
      )
    end

    it "raise error if the order is not PAID or DELIVERED" do
      Order::STATUS.each do |key, value|
        next if value == 'PAID' or value == 'DELIVERED'
        @order.orders_logs.order('created_at').last.update_attribute(
          :status, value
        )
        expect { @order.request_after_sale '没收到货' }.to raise_error(
          RuntimeError, "order status must is PAID or DELIVERED"
        )
      end
    end
  end
end
