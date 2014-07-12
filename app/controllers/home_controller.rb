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
		require 'date'
		
		@timestamp = DateTime.now.strftime('%Q')

		InitInstagramVideos()
		InitVineVideos()

		@leftsidebgcolor = "blue"
		@rightsidebgcolor = "pink"
		@canvascolor = "#db438f"



		offset = rand(Video.count)
		offset2 = rand(Video.count)

		while Video.first(:offset => offset).ignored == true
			offset = rand(Video.count)
		end

		while offset == offset2 
			offset2 = rand(Video.count)
		end

		while Video.first(:offset => offset2).ignored == true || offset2 == offset
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
		
		@leftsidebgcolor = "blue"
		@rightsidebgcolor = "pink"
		@canvascolor = "#db438f"



		offset = rand(Video.count)
		offset2 = rand(Video.count)

		while Video.first(:offset => offset).ignored == true
			offset = rand(Video.count)
		end

		while offset == offset2 
			offset2 = rand(Video.count)
		end

		while Video.first(:offset => offset2).ignored == true || offset2 == offset
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

	def initvinevideos
		
	end
end




