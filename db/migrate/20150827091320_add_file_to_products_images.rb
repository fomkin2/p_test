class AddFileToProductsImages < ActiveRecord::Migration
  def up
    add_attachment :products_images, :file
  end

  def down
    remove_attachment :products_images, :file
  end
end
