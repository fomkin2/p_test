class ProductsImage < ActiveRecord::Base
  has_attached_file :file, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
  belongs_to :product
end
