require 'csv'
namespace :import do
  task :products, [:file_name] => :environment do |task,args|
    file_name = args.file_name
    print("File name is #{file_name}\n")
    n = 0
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers:true,col_sep:"+")
    csv.each do |product|
      if (n%1000) == 0
        print("At number #{n}\n")
      end
      n+= 1
      Product.create(product.to_hash)
    end
  end
  task :images, [:file_name] => :environment do |task,args|
    puts "Here!"
    file_name = args.file_name
    puts file_name
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers:true,col_sep:"+")
    n = 0
    csv.each do |row|
      Image.create(row.to_hash)
      n += 1
      if (n%1500) == 0
        print("At number #{n}\n")
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
