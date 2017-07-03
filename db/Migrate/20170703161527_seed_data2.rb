class SeedData2 < ActiveRecord::Migration[5.1]
  def change
    print("This should take some time.\n")
    Rake::Task['import:products'].invoke("product_export.csv")
    print("Importing images\n")
    Rake::Task['import:images'].invoke("image_export.csv")
    print("Importing artists\n")
    Rake::Task['import:artists'].invoke
    print("Generating matches. This should take several seconds.\n")
    Rake::Task['generate:matches'].invoke
    print("Done with seeding.\n")
  end
end
