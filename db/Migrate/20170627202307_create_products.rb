class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :url
      t.decimal :list_price
      t.decimal :sale_price
#      belongs_to :artists
#      has_many :images
      t.timestamps
    end
  end
end
