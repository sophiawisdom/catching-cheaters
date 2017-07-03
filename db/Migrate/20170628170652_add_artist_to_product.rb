class AddArtistToProduct < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :artist, foreign_key: true
  end
end
