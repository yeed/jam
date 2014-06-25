class AddShareurlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :shareurl, :string
  end
end
