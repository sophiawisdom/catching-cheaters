require 'csv'
# test
class ArtistController < ApplicationController
  # BEFORE_ACTION- LOAD CSV
  def reverse(row)
    # I know this is disgusting and ugly. Any advice on how to make it less so?
    row_2 = {'price_1' => row['price_2'],'price_2' => row['price_1'],'name_1' => row['name_2'],'name_2' => row['name_1']}
    row_2['prod_url_1'] = row['prod_url_2']
    row_2['prod_url_2'] = row['prod_url_1']
    row_2['artist_id_2'] = row['artist_id']
    row_2['image_url_2'] = row['image_url_1']
    row_2['image_url_1'] = row['image_url_2']
    return row_2
  end
  def load_csv
    csv_text = File.read("ruby_matches.csv")
    k = []
    CSV.parse(csv_text,headers:true,col_sep:"+").each do |row|
      data = row.to_hash
      k.append(data)
    end
    return k
  end
  def index
    @artist = Artist.all
    render :index
  end
  def show
    artist_id = params['id']
    puts "Got to line 30"
    @artist_name = Artist.find(artist_id.to_i).name
    puts "Got past it"
    data = load_csv
    artist_matches = []
    data.each do |row|
      if row['artist_id_1'] == artist_id
        artist_matches.append(row)
      elsif row['artist_id_2'] == artist_id
        artist_matches.append((reverse row))
      end
    end
    @artist_matches = artist_matches
    render :show
  end
end
