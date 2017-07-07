namespace :generate do
  task :matches => :environment do
    images = Image.all
    new_images = []
    n = 0
    (0..images.length-1).each do |index|
      if (n%5000)==0
        puts n
      end
      n += 1
      img = images[index].serializable_hash
      img['image_hash'] = img['image_hash'].to_i
      new_images.append(img) # integerize
    end
    images = new_images.sort_by {|image| image['image_hash']} # 2200 MS to run
    length = images.length # very many miliseconds
    last_hash = ""
    groups = []
    curr_group = []
    commit_group_calls = 0
    def commit_group(group)
      artists = []
      commit_group = []
      group.each do |image|
        product = Product.find(image['product_id'])
        next if artists.include? product.artist_id
        artists.append(product.artist_id)
        commit_group.append(image)
      end
      return commit_group if artists.length > 1 # otherwise nil
    end
    n = 0
    last_image = images[-1]
    last_hash = last_image['image_hash']
    images.each do |image|
      curr_hash = image['image_hash']
      first = curr_hash.to_s[-7..-1]
      if curr_hash == last_hash
        curr_group.append image
        curr_group.append last_image
      elsif curr_group.length >= 1
        res = commit_group curr_group
        commit_group_calls += 1
        if res != nil
          groups.append res
        end
        curr_group = []
      else
        curr_group = []
      end
      last_hash = curr_hash
      last_image = image
    end
    n = 0
    csv_format = []
    artist_matches = {}
    groups.each do |group|
      product_1 = Product.find(group[0]['product_id'])
      product_2 = Product.find(group[1]['product_id'])
# We want a name + price, <a>'d to a product url, with an <img> below of the images, queried by artist
      prices = [product_1['price'],product_2['price']]
      names = [product_1['name'],product_2['name']]
      prod_urls = [product_1['url'],product_2['url']]
      artists = [product_1['artist_id'],product_2['artist_id']]
      if artist_matches[artists[0]] == nil
        artist_matches[artists[0]] = {}
      end
      if artist_matches[artists[1]] == nil
        artist_matches[artists[1]] = {}
      end
      if artist_matches[artists[0]][artists[1]] == nil
        artist_matches[artists[0]][artists[1]] = 0
      end
      if artist_matches[artists[1]][artists[0]] == nil
        artist_matches[artists[1]][artists[0]] = 0
      end
      artist_matches[artists[0]][artists[1]] += 1
      artist_matches[artists[1]][artists[0]] += 1
      images = [group[0]['url'],group[1]['url']]
      csv_format.append [prices,names,prod_urls,artists,images]
    end
    # test
    binding.pry
    file = File.open("ruby_matches.csv",'w')
    file.write (['price_1','price_2','name_1','name_2','prod_url_1','prod_url_2','artist_id_1','artist_id_2',\
      'image_url_1','image_url_2'].join("+") + "\n")
    csv_format.each do |row|
      file.write(row.join("+") + "\n")
    end
    file.close
    file = File.open("artist_matches.csv",'w')
    file.write(artist_matches.to_s)
    file.close()
  end
end
