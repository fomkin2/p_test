class AddNewWindowToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :new_window, :boolean
  end
end
