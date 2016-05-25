class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :introduction
      t.text :description
      t.text :information
      t.boolean :published

      t.timestamps
    end
  end
end
