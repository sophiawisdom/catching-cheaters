require 'csv'
namespace :import do
  task :products => :environment do
    file_name = ENV["file_name"]
    n = 0
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers:true,col_sep:"+")
    csv.each do |product|
      Product.create(product.to_hash)
    end
  end
  task :images => :environment do
    file_name = ENV['file_name']
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers:true,col_sep:"+")
    n = 0
    csv.each do |row|
      k = Image.new(row.to_hash)
      k.save!
      n += 1
    end
  end
  task :matches => :environment do
    file_name = ENV['file_name']
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers:true,col_sep:"+")
    n = 0
    csv.each do |row|
      match = ImageMatch.new(row.to_hash)
      match.save!
    end
  end
  task :artists => :environment do
    artists = ['liu', 'guamwork', 'richard3015', 'kanhtart', 'pupuhol', 'lotusmodel', 'bluebird', 'fine3d', 'xiaoq2', 'barmoon',
      'zifir3d', 'fly123', 'beat3dart', 'sparrow', 'monogroup', '3dmaxhouse', 'duyanhpeo', 'acdcz', 'mostusk', 'faint3d', 'havva1972',
      'azurostudio', 'zubr3d', 'modelev']
    artists.each do |artist|
      Artist.create(name:artist)
    end
  end
end
