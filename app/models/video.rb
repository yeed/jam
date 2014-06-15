class Video < ActiveRecord::Base
  attr_accessible :description, :name, :thumbnail_image_url, :url, :view_count, :video_id

end
