# This is a helper file that parses API info according to user arguments
require_relative "../yelp-fusion/yelp-api"
require_relative "../movie-search/movie-api"
require_relative "../google-distance/google-direction"
require 'time'
# Given an object of arguments, return an itinerary JSON object.

def generate_itinerary(params)
  coords = params['coords']
  puts start_time = Time.parse(params['startTime'])
  puts end_time = Time.parse(params['endTime'])
  time_frame = end_time - start_time
  skeleton = params['skeleton']
  itinerary = []

  skeleton.each do |type|
    case type
    when 'Restaurant'
      itinerary << yelp_random(coords)
      start_time = start_time + 6400
    when 'Movie'
      #movie api
      movies_list = get_movies_by_location(coords)
      movie = random_movie(movies_list, start_time, end_time)
      movie = get_movie_details(movie)
      itinerary << movie
      if movie[:error] == nil
        start_time = Time.parse(movie[:start_at])
        puts start_time = start_time + (movie[:runtime] * 60)
        # start_time = start_time + 7200
      end
    else
      #invalid type
    end
  end
  itinerary
end

# Use the google map API to get the route information for the itinerary
def create_route(itinerary)
  locations = []
  itinerary.each do |item|
    locations << item['route_coords']
  end
  get_route(locations)
end
