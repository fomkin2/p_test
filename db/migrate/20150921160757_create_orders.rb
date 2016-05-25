class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.string :status
      t.decimal :price

      t.timestamps
    end
  end
end
