class Product < ActiveRecord::Base
  has_many :products_images
  validates :title, uniqueness: true
end
