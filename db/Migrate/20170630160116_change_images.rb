class ChangeImages < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :hash, :image_hashes
  end
end
