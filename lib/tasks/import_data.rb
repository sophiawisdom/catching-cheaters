require 'csv'
desc "import file"
task :import_product do
  binding.pry
  file_name = ENV["file_name"]
  print("file name is #{file_name}")
  csv_content = File.read(file_name)
  csv = CSV.parse(csv_content, {col_sep:'+',headers:true})
  csv.each { |product|
    Product.new(product.to_hash)
  }
  Product.save
end
