class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name
#      has_many :products
      t.timestamps
    end
  end
end
