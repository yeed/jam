class HomeController < ApplicationController

	def single
		@leftsidebgcolor = "orange"
		@rightsidebgcolor = "darkblue"
	end

	def index
		@leftsidebgcolor = "blue"
		@rightsidebgcolor = "pink"

		offset = rand(Video.count)
		offset2 = rand(Video.count)

		while offset == offset2
			offset2 = rand(Video.count)
		end

		@firstvideo = Video.first(:offset => offset)
		@secondvideo = Video.first(:offset => offset2)

	end

	def initvideos
		require "net/https"
		require "uri"
		require 'json'

		uri = URI.parse("https://api.instagram.com/v1/tags/dance/media/recent?access_token=201508105.1fb234f.23f267ecdf4d409980c2d4163a3e3b4e&max_tag_id=1402827536318607")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		puts response.body

		hash = JSON.parse response.body
		
		@text = ""


		hash['data'].each do |child|

			if child['type'] == "video"
				if Video.exists?(:video_id => child['id'])
					@text << "Video Kaydedilmis :(\n\n"
				else
					unless child['caption'].nil?

						@text << "Video Kaydedilecek!\n\n"

						@videoid = child['id']
						@videoname = child['caption']['text']
						@videourl = child['videos']['standard_resolution']['url']
						@imageurl = child['images']['standard_resolution']['url']
						@username = child['user']['username']

						@text << 'Video Ismi: ' << @videoname << "\n"
						@text << 'Video Url: ' << @videourl << "\n"
						@text << 'Video Image Url: ' << @imageurl << "\n"
						@text << 'Video ID: ' << @videoid << "\n"
						@text << 'User Name: ' << @username << "\n"
		  	
						@video = Video.new

						@video.name = @username
						@video.description = @videoname
						@video.url = @videourl
						@video.thumbnail_image_url = @imageurl
						@video.video_id = @videoid

						@video.save
					else
						@text << "Video has null fields!\n\n"
				  		next
					end
				end
			end
		end
	end
end




