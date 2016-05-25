class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.references :banner_position
      t.string :url
      t.integer :ordering

      t.timestamps
    end
  end
end
