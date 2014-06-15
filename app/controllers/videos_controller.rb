class VideosController < ApplicationController
	def index
		@leftsidebgcolor = "orange"
		@rightsidebgcolor = "pink"

		if request.original_url.include? "pop"
			videos = Video.order("videos.view_count DESC")
		else
			videos = Video.order("videos.created_at DESC")
		end

		@videos = videos
	end


end
