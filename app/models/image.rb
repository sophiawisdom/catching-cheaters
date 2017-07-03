class Image < ApplicationRecord
  belongs_to :product
  belongs_to :image_match
end
