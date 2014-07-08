module HomeHelper

	def InitInstagramVideos()
		require "net/https"
		require "uri"
		require 'json'

		begin
			uri = URI.parse("https://api.instagram.com/v1/tags/Jam25kentry/media/recent?access_token=201508105.1fb234f.23f267ecdf4d409980c2d4163a3e3b4e&max_tag_id=1402827536318607")
				http = Net::HTTP.new(uri.host, uri.port)
				http.use_ssl = true
				http.verify_mode = OpenSSL::SSL::VERIFY_NONE

				request = Net::HTTP::Get.new(uri.request_uri)

				response = http.request(request)
				puts response.body

				hash = JSON.parse response.body


				hash['data'].each do |child|

					if child['type'] == "video"
						unless Video.exists?(:video_id => child['id'])
							unless child['caption'].nil?
								video = Video.new

								video.name = child['user']['username']
								video.description =  child['caption']['text']
								video.url = child['videos']['standard_resolution']['url']
								video.thumbnail_image_url = child['images']['standard_resolution']['url']
								video.video_id = videoid = child['id']
								video.view_count = 0
								video.shareurl = child['link']

								video.save
							else
						  		next
							end
						end
					end
				end
		rescue => ex
		  logger.error ex.message
		end
		
	end


	def InitVineVideos()
		require "net/https"
		require "uri"
		require 'json'

		begin
		uri = URI.parse("https://api.vineapp.com/timelines/tags/Jam25kentry")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		puts response.body

		hash = JSON.parse response.body

		hash['data']['records'].each do |child|
			unless Video.exists?(:video_id => child['postId'].to_s)
				video = Video.new

				video.name = child['username']
				video.description = child['description']
				video.url = child['videoUrl']
				video.thumbnail_image_url = child['thumbnailUrl']
				video.video_id = child['postId'].to_s
				video.view_count = 0
				video.shareurl = child['shareUrl']

				video.save
			end
		end

		rescue => ex
		  logger.error ex.message
		end

	end


end
