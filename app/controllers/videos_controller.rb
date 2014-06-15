class VideosController < ApplicationController
	def index
		@leftsidebgcolor = "orange"
		@rightsidebgcolor = "pink"

		@videos = Video.all
	end


end
