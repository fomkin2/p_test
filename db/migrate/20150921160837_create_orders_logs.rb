class CreateOrdersLogs < ActiveRecord::Migration
  def change
    create_table :orders_logs do |t|
      t.references :order, index: true
      t.references :admin, index: true
      t.string :comment

      t.timestamps
    end
  end
end
