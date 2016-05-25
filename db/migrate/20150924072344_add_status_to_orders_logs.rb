class AddStatusToOrdersLogs < ActiveRecord::Migration
  def change
    add_column :orders_logs, :status, :string
  end
end
