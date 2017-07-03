require 'csv'
namespace :update do
  task :prices => :environment do
    csv_text = File.read("product_export.csv")
    csv = CSV.parse(csv_text,headers:true,col_sep:"+")
    n = 0
    csv.each do |row|
      n += 1
      if (n%100) == 0
        puts n
      end
      prod = Product.find(row['id'])
      prod.update({list_price:row['list_price'],sale_price:row['sale_price']})
    end
  end
end
