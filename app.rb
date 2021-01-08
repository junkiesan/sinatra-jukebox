require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require "sqlite3"

# set :bind, '0.0.0.0'
DB = SQLite3::Database.new(File.join(File.dirname(__FILE__), 'db/jukebox.sqlite'))

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @names = DB.execute("SELECT name, id FROM artists").sort
  erb :home
end

get '/artists/:id' do
  DB.results_as_hash = false
  @albums = DB.execute("SELECT albums.title, albums.id FROM albums JOIN artists ON artists.id = albums.artist_id WHERE artist_id = ?", params[:id].to_i)
  @artist_name = DB.execute("SELECT name FROM artists WHERE id = ?", params[:id].to_i).flatten[0]
  erb :artist
end

# binding.pry
get '/albums/:id' do
  DB.results_as_hash = false
  @tracks = DB.execute("SELECT tracks.name, tracks.id FROM tracks JOIN albums ON albums.id = tracks.album_id WHERE album_id = ?", params[:id].to_i)
  @album_name = DB.execute("SELECT title FROM albums WHERE id = ?", params[:id]).flatten[0]
  erb :album
end

get '/tracks/:id' do
  DB.results_as_hash = true
  @track = DB.execute("SELECT * FROM tracks WHERE id = ?", params[:id].to_i).flatten[0]
  erb :track
end