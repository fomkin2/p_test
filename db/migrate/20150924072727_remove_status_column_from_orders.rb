class RemoveStatusColumnFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :status, :string
  end
end
