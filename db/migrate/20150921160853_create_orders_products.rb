class CreateOrdersProducts < ActiveRecord::Migration
  def change
    create_table :orders_products do |t|
      t.references :order, index: true
      t.references :product, index: true
      t.decimal :price
      t.text :snapshot

      t.timestamps
    end
  end
end
