# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require 'uri'
# require 'net/http'

# url = URI("https://tmdb.lewagon.com/movie/top_rated")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true

# request = Net::HTTP::Get.new(url)
# request["accept"] = 'application/json'

# response = http.request(request)
# parsed_response_body = JSON.parse(response.read_body)
# movies = parsed_response_body["results"]
# movies.each do |movie|
#   Movie.new(title: movie["title"])
# end

# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)

require 'json'
require 'open-uri'
Movie.destroy_all
url = 'https://tmdb.lewagon.com/movie/top_rated'
movie_serialized = URI.open(url).read
movies = JSON.parse(movie_serialized)
movies['results'].each do |movie|
  Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: movie['poster_path'],
    rating: movie['vote_average']
  )
end
puts "finish - #{Movie.count} movies created"
