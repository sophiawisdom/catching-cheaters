class ChangeLPriceName < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :list_price, :price
  end
end
