require_relative '../helpers/itinerary_builder'

class ItinerariesController < ApplicationController
  def create
    result = {}
    puts params
    result[:itinerary] = generate_itinerary(params)
    result[:route] = create_route(result[:itinerary])
    render json: result
  end
end