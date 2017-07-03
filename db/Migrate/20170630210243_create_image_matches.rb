class CreateImageMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :image_matches do |t|
      t.string :image_hash
      t.string :first_product_url
      t.string :second_product_url
      t.timestamps
    end
  end
end
