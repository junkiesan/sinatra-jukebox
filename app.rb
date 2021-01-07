require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

# set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @usernames = [ 'ssaunier', 'Papillard' ]
  erb :index
end

get '/about' do
  erb :about
end

# binding.pry
get '/team/:username' do
  puts params[:username]
  "The user is #{params[:username]}"
end