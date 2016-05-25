class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.string :name
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
