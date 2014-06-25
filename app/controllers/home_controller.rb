class HomeController < ApplicationController
	protect_from_forgery except: :index

	def single

		@leftsidebgcolor = "orange"
		@rightsidebgcolor = "darkblue"
		@canvascolor = "#3072c4"


		offset = rand(Video.count)

		@video = Video.first(:offset => offset)

	end

	def index
		@leftsidebgcolor = "blue"
		@rightsidebgcolor = "pink"
		@canvascolor = "#db438f"

		offset = rand(Video.count)
		offset2 = rand(Video.count)

		while offset == offset2
			offset2 = rand(Video.count)
		end

		@firstvideo = Video.first(:offset => offset)
		@secondvideo = Video.first(:offset => offset2)

		if params[:winner] != nil
			winner = Integer(params[:winner])

		    video = Video.find(winner)

		    video.view_count = video.view_count + 1
		    
		    video.save
       
		    redirect_to :back
	    end

	end

	def whopass
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
						@shareurl = child['link']

						@text << 'Video Ismi: ' << @videoname << "\n"
						@text << 'Video Url: ' << @videourl << "\n"
						@text << 'Video Image Url: ' << @imageurl << "\n"
						@text << 'Video ID: ' << @videoid << "\n"
						@text << 'User Name: ' << @username << "\n"
						@text << 'Share url: ' << @shareurl << "\n"
		  	
						@video = Video.new

						@video.name = @username
						@video.description = @videoname
						@video.url = @videourl
						@video.thumbnail_image_url = @imageurl
						@video.video_id = @videoid
						@video.view_count = 0
						@video.shareurl = @shareurl

						@video.save
					else
						@text << "Video has null fields!\n\n"
				  		next
					end
				end
			end
		end
	end

	def initvinevideos
		require "net/https"
		require "uri"
		require 'json'


		@leftsidebgcolor = "yellow"
		@rightsidebgcolor = "yellow"

		uri = URI.parse("https://api.vineapp.com/timelines/tags/dance")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		puts response.body

		hash = JSON.parse response.body
		

		@text = ""

		hash['data']['records'].each do |child|

			if Video.exists?(:video_id => child['postId'].to_s)
				@text << "Video Kaydedilmis :(\n\n"
			else
				@text << 'Video Url: ' << child['postId'].to_s << "\n"
				@text << 'Video Url: ' << child['videoUrl'] << "\n"
				@text << 'Video Ismi: ' << child['description'] << "\n"
				@text << 'Video Image Url: ' << child['thumbnailUrl'] << "\n"
				@text << 'Share Url: ' << child['shareUrl'] << "\n"
				@text << 'User Name: ' << child['username'] << "\n\n\n"

				@video = Video.new

				@video.name = child['username']
				@video.description = child['description']
				@video.url = child['videoUrl']
				@video.thumbnail_image_url = child['thumbnailUrl']
				@video.video_id = child['postId'].to_s
				@video.view_count = 0
				@video.shareurl = child['shareUrl']

				@video.save
			end
		end
	end
end




