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

get '/artists/:id' do
  DB.results_as_hash = false
  @artist = DB.execute("SELECT name FROM artists WHERE id = ?", params[:id].to_i)[0][0]
  @albums = DB.execute("SELECT albums.title, albums.id FROM albums JOIN artists ON albums.artist_id = artists.id WHERE artist_id = ?", params[:id].to_i)
  erb :artist
end

get '/albums/:id' do
  DB.results_as_hash = false
  @tracks = DB.execute("SELECT tracks.name,tracks.id FROM tracks
                        JOIN albums ON albums.id = tracks.album_id
                        WHERE albums.id = ?", params[:id].to_i)
  @album = DB.execute("SELECT title FROM albums WHERE id = ?", params[:id])[0]
  erb :album
end

get '/tracks/:id' do
  @track = DB.execute("SELECT * FROM tracks WHERE id = ?", params[:id]).flatten
  erb :track
end
