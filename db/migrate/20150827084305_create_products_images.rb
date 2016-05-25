class CreateProductsImages < ActiveRecord::Migration
  def change
    create_table :products_images do |t|
      t.references :product, index: true
      t.integer :ordering

      t.timestamps
    end
  end
end
