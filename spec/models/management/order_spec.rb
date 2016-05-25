require 'rails_helper'

RSpec.describe Management::Order, type: :model do
  let(:product) { create :product }
  let(:user) { create :user }
  let(:admin) { create :admin }

  before(:example) do
    create :cart, user: user, product: product, number: 10
    order    = Order.place_order user: user, comment: 'phone: 180180180180'
    @m_order = Management::Order.find order.id
  end

  describe 'deliver' do
    it 'deliver a order' do
      @m_order.orders_logs.order('created_at').last.update_attribute(
        :status, 'PAID'
      )
      @m_order.set_status 'DELIVERED', admin.id, '快递单号：123123'
      expect(@m_order.status).to eq('DELIVERED')
      expect(@m_order.orders_logs.order('created_at').last.admin).to eq(admin)
      expect(@m_order.orders_logs.order('created_at').last.comment).to eq('快递单号：123123')
    end

    it 'raise error if without comment' do
      expect { @m_order.set_status 'DELIVERED', admin.id, '' }.to raise_error(
        RuntimeError, "comment is required"
      )
    end

    it 'can not deliver if order is not PAID' do
      Order::STATUS.each do |key, value|
        next if value == 'PAID'
        @m_order.orders_logs.order('created_at').last.update_attribute(
          :status, value
        )
        expect { @m_order.set_status 'DELIVERED', admin.id, '快递单号：123123' }.to raise_error(
          RuntimeError, "order status must PAID"
        )
      end
    end
  end

  describe 'finish_after_sale' do
    it 'finish_after_sale a order' do
      @m_order.orders_logs.order('created_at').last.update_attribute(
        :status, 'AFTER_SALE_REQUESTED'
      )
      @m_order.set_status 'AFTER_SALE_FINISHED', admin.id, '已经重新发货'
      expect(@m_order.status).to eq('AFTER_SALE_FINISHED')
      expect(@m_order.orders_logs.order('created_at').last.admin).to eq(admin)
      expect(@m_order.orders_logs.order('created_at').last.comment).to eq('已经重新发货')
    end

    it 'raise error if without comment' do
      expect { @m_order.set_status 'AFTER_SALE_FINISHED', admin.id, '' }.to raise_error(
        RuntimeError, "comment is required"
      )
    end

    it 'can not finish_after_sale if order is not AFTER_SALE_REQUESTED' do
      Order::STATUS.each do |key, value|
        next if value == 'AFTER_SALE_REQUESTED'
        @m_order.orders_logs.order('created_at').last.update_attribute(
          :status, value
        )
        expect { @m_order.set_status 'AFTER_SALE_FINISHED', admin.id, '已经重新发货' }.to raise_error(
          RuntimeError, "order status must AFTER_SALE_REQUESTED"
        )
      end
    end
  end

  describe 'refund' do
    it 'refund a order' do
      @m_order.orders_logs.order('created_at').last.update_attribute(
        :status, 'AFTER_SALE_REQUESTED'
      )
      @m_order.set_status 'REFUNDED', admin.id, '老板同意退款'
      expect(@m_order.status).to eq('REFUNDED')
      expect(@m_order.orders_logs.order('created_at').last.admin).to eq(admin)
      expect(@m_order.orders_logs.order('created_at').last.comment).to eq('老板同意退款')
    end

    it 'raise error if without comment' do
      expect { @m_order.set_status 'REFUNDED', admin.id, '' }.to raise_error(
        RuntimeError, "comment is required"
      )
    end

    it 'can not refund if order is not AFTER_SALE_REQUESTED' do
      Order::STATUS.each do |key, value|
        next if value == 'AFTER_SALE_REQUESTED'
        @m_order.orders_logs.order('created_at').last.update_attribute(
          :status, value
        )
        expect { @m_order.set_status 'REFUNDED', admin.id, '老板同意退款' }.to raise_error(
          RuntimeError, "order status must AFTER_SALE_REQUESTED"
        )
      end
    end
  end

  describe 'pay' do
    it 'pay a order' do
      @m_order.set_status 'PAID', admin.id, '客户直接把钱给我'
      expect(@m_order.status).to eq('PAID')
      expect(@m_order.orders_logs.order('created_at').last.admin).to eq(admin)
      expect(@m_order.orders_logs.order('created_at').last.comment).to eq('客户直接把钱给我')
    end

    it 'raise error if admin id not found' do
      expect { @m_order.set_status 'PAID', 99, '客户直接把钱给我' }.to raise_error(
        ActiveRecord::RecordNotFound, "Couldn't find Admin with 'id'=99"
      )
    end

    it 'raise error if without comment' do
      expect { @m_order.set_status 'PAID', admin.id, '' }.to raise_error(
        RuntimeError, "comment is required"
      )
    end

    it 'raise error if order status is not CREATED' do
      Order::STATUS.each do |key, value|
        next if value == 'CREATED'
        @m_order.orders_logs.order('created_at').last.update_attribute(
          :status, value
        )
        expect { @m_order.set_status 'PAID', admin.id, '客户直接把钱给我' }.to raise_error(
          RuntimeError, "order status must CREATED"
        )
      end
    end
  end

  describe 'cancel' do
    it 'cancel order' do
      @m_order.set_status 'CANCELED', admin.id, '客户说不买了'
      expect(@m_order.status).to eq('CANCELED')
      expect(@m_order.orders_logs.order('created_at').last.admin).to eq(admin)
      expect(@m_order.orders_logs.order('created_at').last.comment).to eq('客户说不买了')
    end

    it 'raise error if admin id not found' do
      expect { @m_order.set_status 'CANCELED', 99, '客户说不买了' }.to raise_error(
        ActiveRecord::RecordNotFound, "Couldn't find Admin with 'id'=99"
      )
    end

    it 'raise error if without comment' do
      expect { @m_order.set_status 'CANCELED', admin.id, '' }.to raise_error(
        RuntimeError, "comment is required"
      )
    end

    it 'raise error if order status is not CREATED' do
      Order::STATUS.each do |key, value|
        next if value == 'CREATED'
        @m_order.orders_logs.order('created_at').last.update_attribute(
          :status, value
        )
        expect { @m_order.set_status 'CANCELED', admin.id, '客户说不买了' }.to raise_error(
          RuntimeError, "order status must CREATED"
        )
      end
    end
  end
end
