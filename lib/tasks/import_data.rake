require 'csv'
require 'pry'
namespace :import do
  task :products => :environment do
    file_name = ENV["file_name"]
    print("file name is #{file_name}\n")
    n = 0
    csv_text = File.read(file_name)
    puts "Read file"
    csv = CSV.parse(csv_text, headers:true,col_sep:"+")
    puts "Parsing done"
    csv.each do |product|
      Product.create(product.to_hash)
      n+= 1
      if (n%50) == 0
        print "Starting #{n}\n"
      end
    end
  end
  task :images => :environment do
    file_name = ENV['file_name']
    print("file name is #{file_name}\n")
    csv_text = File.read(file_name)
    puts "Read file"
    csv = CSV.parse(csv_text, headers:true,col_sep:"+")
    puts "Parsing done"
    n = 0
    csv.each do |row|
      k = Image.new(row.to_hash)
      k.save!
      if (n%50)==0
        print "Startin #{n}\n"
      end
      n += 1
    end
    Image.all.each { |image|
      print "#{image.url}"
    }
  end
  task :matches => :environment do
    file_name = ENV['file_name']
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers:true,col_sep:"+")
    puts "Got file and parsed"
    n = 0
    csv.each do |row|
      match = ImageMatch.new(row.to_hash)
      match.save!
      if (n%50)==0
        print "On #{n}\n"
      end
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
