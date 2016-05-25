class AddOrderingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ordering, :integer
  end
end
