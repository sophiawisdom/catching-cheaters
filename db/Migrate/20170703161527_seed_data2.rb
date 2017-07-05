class SeedData2 < ActiveRecord::Migration[5.1]
  def change
=begin
    Rake::Task['import:products'].invoke("product_export.csv")
    print("Importing images\n")
    Rake::Task['import:images'].invoke("image_export.csv")
    print("Generating matches. This should take several seconds.\n")
    Rake::Task['generate:matches'].invoke
    print("Done with seeding.\n")
=end
  end
end
