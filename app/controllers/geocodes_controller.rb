require 'net/http'
require 'uri'
require 'rubygems'
require 'json'

class GeocodesController < ApplicationController

	def index
		@geocodes = Geocode.all
	end

	def create
		@geocode = Geocode.new(params.require(:geocode).permit(:address))

		url = URI.parse('https://maps.googleapis.com/maps/api/geocode/json?address=' + @geocode.address + '&key=AIzaSyCiDxNCpN9bvKo4mT5oIJP0siemEGqmnLc')
		req = Net::HTTP::Post.new(url.request_uri)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = (url.scheme == "https")
		response = http.request(req)

		@geocode.latitude = JSON.parse(response.body)['results'][0]['geometry']["location"]["lat"]
		@geocode.longitude = JSON.parse(response.body)['results'][0]['geometry']["location"]["lng"]
		@geocode.save

		puts "geocode ALL"
		puts @geocode.latitude
		puts @geocode.longitude
		redirect_to "/"
	end

	private
	  def geocode_params
	    
	  end

end
