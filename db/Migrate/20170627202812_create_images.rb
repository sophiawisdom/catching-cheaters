class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :url
      t.string :hash
#      belongs_to :products
      t.timestamps
    end
  end
end
