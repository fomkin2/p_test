class CreateBannerPositions < ActiveRecord::Migration
  def change
    create_table :banner_positions do |t|
      t.string :description
      t.string :size

      t.timestamps
    end
  end
end
