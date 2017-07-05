# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
artists = ['liu', 'guamwork', 'richard3015', 'kanhtart', 'pupuhol', 'lotusmodel', 'bluebird', 'fine3d', 'xiaoq2', 'barmoon',
  'zifir3d', 'fly123', 'beat3dart', 'sparrow', 'monogroup', '3dmaxhouse', 'duyanhpeo', 'acdcz', 'mostusk', 'faint3d', 'havva1972',
  'azurostudio', 'zubr3d', 'modelev']
artists.each do |artist|
  Artist.create(name:artist)
end
print("Creating products\n")
Rake::Task['import:products'].invoke("product_export.csv")
print("Creating Images\n")
Rake::Task['import:images'].invoke("image_export.csv")
Rake::Task['generate:matches'].invoke
