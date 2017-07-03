class FixImages < ActiveRecord::Migration[5.1]
  def change
    add_reference :images, :product, index: true, foreign_key: true
  end
end
