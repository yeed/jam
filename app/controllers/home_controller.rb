class HomeController < ApplicationController

	def single
		@leftsidebgcolor = "orange"
		@rightsidebgcolor = "darkblue"
	end

	def index
		@leftsidebgcolor = "blue"
		@rightsidebgcolor = "pink"
	end

	def initvideos

		require "net/https"
		require "uri"
		require 'json'

		uri = URI.parse("https://api.instagram.com/v1/users/201508105/media/recent?access_token=201508105.1fb234f.23f267ecdf4d409980c2d4163a3e3b4e")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		puts response.body

		hash = JSON.parse response.body
		
		@text = ""


		hash['data'].each do |child|

			if Video.exists?(:video_id => child['id'])
				@text << "Video Kaydedilmis :(\n"
			else
				@text << "Video Kaydedilecek!\n"
			
				@videoname = child['caption']['text']
				@videoid = child['id']
				@videourl = child['videos']['standard_resolution']['url']
				@imageurl = child['images']['standard_resolution']['url']

				@text << 'Video Ismi: ' << @videoname << "\n"
				@text << 'Video Url: ' << @videourl << "\n"
				@text << 'Video Image Url: ' << @imageurl << "\n"
				@text << 'Video ID: ' << @videoid << "\n\n\n"

  	
				@video = Video.new

				@video.name = @videoname
				@video.description = @videoname
				@video.url = @videourl
				@video.thumbnail_image_url = @imageurl
				@video.video_id = @videoid

				@video.save
			end
		
			/@text << child['videos']['low_bandwidth']['url']/
		end


	end

end




