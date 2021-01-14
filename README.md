### sinatra-jukebox

[Sinatra](http://sinatrarb.com/) is a DSL for quickly creating web applications in Ruby with minimal effort.

This project was about understanding the Sinatra framework building a small application with a sqlite3 database.

I focused on building the routes and blocks (querying the db saving as instance variables to pass to the view) in the app.rb file then creating views accordingly. No styling implemented. 

The app basically consists of 4 pages:
- homepage: Displaying all artists each linking to an artist page
- artist-page: Displaying all albums of the artist each linking to the album page
- album-page: Displaying all tracks of the album each linking to the track page
- track-page: Displaying all track info

