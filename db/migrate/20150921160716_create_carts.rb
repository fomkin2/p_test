class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :product, index: true
      t.references :user, index: true
      t.integer :number

      t.timestamps
    end
  end
end
