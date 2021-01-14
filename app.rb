require 'sinatra'
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require "sqlite3"

DB = SQLite3::Database.new(File.join(File.dirname(__FILE__), 'db/jukebox.sqlite'))

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @artists = DB.execute("SELECT name, id FROM artists").sort
  erb :home
end

get 'artists/:id' do
  @artist = DB.execute("SELECT * FROM artists WHERE id = ?", params[:id].to_i)
  erb :artist
end
