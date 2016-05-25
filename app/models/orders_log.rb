class OrdersLog < ActiveRecord::Base
  belongs_to :order
  belongs_to :admin
end
