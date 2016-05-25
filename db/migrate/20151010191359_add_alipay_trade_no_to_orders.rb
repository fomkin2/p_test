class AddAlipayTradeNoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :alipay_trade_no, :string
  end
end
