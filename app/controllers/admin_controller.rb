class AdminController < ApplicationController
  layout "blank"
  

  # GET /videos
  # GET /videos.json
  def index
    @leftsidebgcolor = "orange"
    @rightsidebgcolor = "darkblue"
    @videos = Video.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

  # GET /videos/1/edit
  def edit
    @leftsidebgcolor = "orange"
    @rightsidebgcolor = "darkblue"
    @video = Video.find(params[:id])
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

end
