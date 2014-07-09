class HomeController < ApplicationController
	protect_from_forgery except: :index
	include HomeHelper
	def single

		@leftsidebgcolor = "orange"
		@rightsidebgcolor = "darkblue"
		@canvascolor = "#3072c4"


		offset = rand(Video.count)

		@video = Video.first(:offset => offset)

	end

	def index


		view_context.InitInstagramVideos
		view_context.InitVineVideos

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
		
	end

	def initvinevideos
		
	end
end




