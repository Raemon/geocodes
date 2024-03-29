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

		key = "AIzaSyCiDxNCpN9bvKo4mT5oIJP0siemEGqmnLc"

		url = URI.parse('https://maps.googleapis.com/maps/api/geocode/json?address=' + @geocode.address + '&key=' + key)
		req = Net::HTTP::Post.new(url.request_uri)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = (url.scheme == "https")
		response = http.request(req)

		@geocode.latitude = JSON.parse(response.body)['results'][0]['geometry']["location"]["lat"]
		@geocode.longitude = JSON.parse(response.body)['results'][0]['geometry']["location"]["lng"]
		@geocode.save

		redirect_to "/"
	end

end
