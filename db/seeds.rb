require "json"
require "open-uri"

puts "cleaning seeds"

Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
search = URI.open(url).read
movies_resp = JSON.parse(search)
movies = movies_resp["results"]

puts "seeding..."

movies.sample(10).each do |movie|
  Movie.create(title: movie["original_title"],
              overview: movie["overview"],
              poster_url: "https://image.tmdb.org/t/p/w500/#{movie["poster_path"]}",
              rating: movie["vote_average"])
end

puts "finished!"
