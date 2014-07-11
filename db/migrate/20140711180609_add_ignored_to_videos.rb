class AddIgnoredToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :ignored, :boolean
  end
end
