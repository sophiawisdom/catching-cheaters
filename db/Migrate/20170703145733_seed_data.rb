class SeedData < ActiveRecord::Migration[5.1]
  def change
    if Product.count < 10000
      print("This should take some time.\n")
      Rake::Task['import:products'].invoke("products_export.csv")
    end
    if Image.count < 10000
      print("Importing images\n")
      Rake::Task['import:images'].invoke("image_export.csv")
    end
    if Artist.count > 10
      print("Importing artists\n")
      Rake::Task['import:artists'].invoke
    end
    print("Generating matches. This should take several seconds.\n")
    Rake::Task['generate:matches'].invoke
    print("Done with seeding.\n")
  end
end
