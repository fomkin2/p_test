class Order < ActiveRecord::Base
  belongs_to :user
  has_many :orders_products
  has_many :orders_logs

  validates :user, presence: true

  after_save :generate_uid

  STATUS = {
    '等待支付' => 'CREATED',
    '已取消'  => 'CANCELED',
    '已支付'  => 'PAID',
    '已发货'  => 'DELIVERED',
    '发起售后' => 'AFTER_SALE_REQUESTED',
    '售后完成' => 'AFTER_SALE_FINISHED',
    '已退款'  => 'REFUNDED',
  }

  def self.status_text status
    STATUS.each do |key, value|
      return key if value == status
    end
  end

  def status
    self.orders_logs.order('created_at').last.status
  end

  def self.place_order user:, comment: ''
    return false if Cart.empty_cart? user
    order = Order.new user: user, price: 0
    Order.transaction do
      order.save
      Cart.where(user: user).each do |cart|
        order.orders_products.create(
          product:  cart.product,
          price:    cart.product.price,
          number:   cart.number,
          snapshot: cart.product.to_json,
        )
        order.price += cart.product.price * cart.number
        cart.delete
      end
      order.save
      order.orders_logs.create status: 'CREATED', comment: comment
    end
    order
  end

  def request_after_sale comment
    raise 'comment is required' if comment.blank?
    if self.status != 'PAID' && self.status != 'DELIVERED'
      raise 'order status must is PAID or DELIVERED'
    end
    self.orders_logs.create status: 'AFTER_SALE_REQUESTED', comment: comment
  end

  private

  def generate_uid
    self.reload
    return self if self.uid.present?
    t = self.created_at
    current_hour = (t - t.min.minutes - t.sec.seconds).utc
    count_orders_in_current_hour = Order.where(
      "created_at > '#{current_hour}'"
    ).count
    prefix = ''
    prefix = Rails.env.to_s[0].upcase unless Rails.env.to_s[0] == 'p'
    self.uid = prefix + t.strftime('%y%m%d%H') +
               count_orders_in_current_hour.to_s.rjust(4, '0')
    self.save
  end

end
