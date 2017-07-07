require 'csv'
require 'pry'
#       <%= link_to ("/artist/#{match['artist_id_2']}"), (" - " + @id_to_artist[match['artist_id_2']])%><br> </td>
class ArtistController < ApplicationController
  # BEFORE_ACTION- LOAD CSV
  def reverse(row)
    # I know this is disgusting and ugly. Any advice on how to make it less so?
    row_2 = {'price_1' => row['price_2'],'price_2' => row['price_1'],'name_1' => row['name_2'],'name_2' => row['name_1']}
    row_2['prod_url_1'] = row['prod_url_2']
    row_2['prod_url_2'] = row['prod_url_1']
    row_2['artist_id_2'] = row['artist_id_1']
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
    artist_to_id = {}
    file = File.open("artist_matches.csv")
    artist_matches = eval file.read
    file.close
    Artist.all.each do |artist|
      artist_to_id[artist.name] = artist.id.to_s
    end
    @artist_to_id = artist_to_id
    @model_count = {}
    Artist.all.each do |artist|
      where_res = Product.where(artist_id: artist.id)
      @model_count[artist.name] = where_res.count
    end
    @match_count = {}
    Artist.all.each do |artist|
      @match_count[artist.id.to_s] = [0,[]]
    end
    matches = load_csv
    matches.each do |match|
      @match_count[match['artist_id_1']][0] += 1
      @match_count[match['artist_id_2']][0] += 1
      unless @match_count[match['artist_id_1']][1].include? match['artist_id_2']
        @match_count[match['artist_id_1']][1].append(match['artist_id_2'])
      end
      unless @match_count[match['artist_id_2']][1].include? match['artist_id_1']
        @match_count[match['artist_id_2']][1].append(match['artist_id_1'])
      end
    end
    Artist.all.each do |artist|
      @match_count[artist.name] = artist_matches.count
    end
    id_to_artist = {}
    Artist.all.each do |artist|
      id_to_artist[artist.id.to_s] = artist.name.capitalize
    end
    @id_to_artist = id_to_artist
    render :index
  end

  def show
    artist_id = params['id']
    @artist_name = Artist.find(artist_id.to_i).name
    data = load_csv
    artist_matches = []
    data.each do |row|
      if row['artist_id_1'] == artist_id
        artist_matches.append(row)
      elsif row['artist_id_2'] == artist_id
        artist_matches.append((reverse row))
      end
    end
    id_to_artist = {}
    Artist.all.each do |artist|
      id_to_artist[artist.id.to_s] = artist.name.capitalize
    end
    @id_to_artist = id_to_artist
    @artist_matches = artist_matches
    render :show
  end
end
