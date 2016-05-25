require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:product) { create :product }
  let(:user) { create :user }
  let(:cart) { create :cart, product: product, user: user }

  it 'empty_cart?' do
    expect(Cart.empty_cart? user).to be true
  end

  describe 'add' do
    it 'add products exists with the user' do
      Cart.add product: product, user: user
      Cart.add product: product, user: user
      Cart.add product: product, user: user, number: 3
      expect(Cart.where(product: product, user: user).first.number).to eq(5)
    end

    it 'with unpublish product' do
      product.update_attribute(:published, false)
      cart = Cart.add product: product, user: user
      expect(cart.errors[:product]).to eq(['can not add unpublished product'])
    end

    it 'with 0 price' do
      cart = Cart.add product: product, user: user, number: 0
      expect(cart.errors[:product]).to eq(['can not add zero price'])
      product.update_attribute(:price, 0)
      cart = Cart.add product: product, user: user
      expect(cart.errors[:product]).to eq(['can not add zero price'])
    end

    it 'success' do
      expect { Cart.add product: product, user: user }.to change{ Cart.count }.by(1)
      expect(Cart.last.product).to eq(product)
      expect(Cart.last.user).to eq(user)
      expect(Cart.last.number).to eq(1)
    end

    it 'no product' do
      expect { Cart.add user: user }.to raise_error(ArgumentError)
    end

    it 'no user' do
      expect { Cart.add product: product }.to raise_error(ArgumentError)
    end
  end

  describe 'reduce' do
    it 'can\'t reduce when it has 1' do
      expect(cart.reduce).to eq(false)
    end

    it 'success' do
      cart.update_attribute(:number, 2)
      expect(cart.reduce).to eq(true)
      expect(cart.number).to eq(1)
    end
  end

  describe 'increase' do
    it 'success' do
      expect(cart.increase).to eq(true)
      expect(cart.number).to eq(2)
    end
  end
end
