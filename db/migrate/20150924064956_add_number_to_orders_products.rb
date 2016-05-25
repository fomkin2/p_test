class AddNumberToOrdersProducts < ActiveRecord::Migration
  def change
    add_column :orders_products, :number, :integer
  end
end
