class Cart < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validate :can_not_add_unpublished_product, :can_not_add_zero_price

  validates :product, presence: true
  validates :user, presence: true
  validates :number, presence: true

  def self.empty_cart? user
    Cart.where(user: user).blank?
  end

  def self.add(product:, user:, number: 1)
    if (cart = Cart.where(product: product, user: user).first).present?
      cart.number += number
      return cart.save
    end
    create product: product, user: user, number: number
  end

  def reduce
    if self.number > 1
      self.number -= 1
      return self.save
    end
    false
  end

  def increase
    self.number += 1
    self.save
  end

  def price
    self.product.price
  end

  def product_img
    return '' if self.product.products_images.blank?
    self.product.products_images.order('ordering desc').first.file.url
  end

  def product_title
    self.product.title
  end

  private

  def self.create params
    super params
  end

  def self.save params
    super params
  end

  def self.update params
    super params
  end

  def can_not_add_unpublished_product
    if self.product.published == false
      errors.add(:product, "can not add unpublished product")
    end
  end

  def can_not_add_zero_price
    if self.product.price * self.number == 0
      errors.add(:product, "can not add zero price")
    end
  end
end
