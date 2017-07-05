class DeleteSalePrice < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :sale_price
  end
end
