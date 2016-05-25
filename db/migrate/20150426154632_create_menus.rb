class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.references :menu_type, index: true
      t.references :page, index: true
      t.references :menu, index: true
      t.string :title
      t.string :url
      t.string :position
      t.integer :ordering, default: 0

      t.timestamps
    end
  end
end
