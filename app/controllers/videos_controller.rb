class VideosController < ApplicationController
	def index
		@leftsidebgcolor = "orange"
		@rightsidebgcolor = "pink"
		@canvascolor = "#db438f"

		if request.original_url.include? "pop"
			videos = Video.order("videos.view_count DESC")
		else
			videos = Video.order("videos.created_at DESC")
		end

		@searchmode = false

		if params['search'] != nil
			videos = videos.where(name: params['search'])
			
			
			@searchmode = true

			if videos.count > 0
				@rightsidebgcolor = "darkblue"
				@canvascolor = "#3072c4"
			end

		end
		
		@videos = videos
		@searchparam = params['search']
	end


end
