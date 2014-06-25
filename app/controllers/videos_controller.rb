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
			temp = videos.where(name: params['search'])
			
			if temp.count > 0
				videos = temp
				@rightsidebgcolor = "darkblue"
				@canvascolor = "#3072c4"
				@searchmode = true
			else
				redirect_to :action => "index"
			end

		end
		
		@videos = videos
		@searchparam = params['search']
	end


end
