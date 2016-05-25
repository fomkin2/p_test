class AddPriceAndLinkToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, :integer
    add_column :products, :link, :string
  end
end
