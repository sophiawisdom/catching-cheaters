class FixImageHashColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :image_hashes, :image_hash
  end
end
