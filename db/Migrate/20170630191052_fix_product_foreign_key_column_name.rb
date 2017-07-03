class FixProductForeignKeyColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :products_id, :product_id
  end
end
