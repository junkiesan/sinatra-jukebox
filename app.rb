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
  erb :artist
end

# binding.pry
get '/albums/:id' do
  puts params[:username]
  erb :album
end

get '/tracks/:id' do
  puts params[:username]
  erb :track
end