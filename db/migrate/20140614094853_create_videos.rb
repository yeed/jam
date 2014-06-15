class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.integer :view_count
      t.string :url
      t.string :thumbnail_image_url

      t.timestamps
    end
  end
end
