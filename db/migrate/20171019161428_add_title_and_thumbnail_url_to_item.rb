class AddTitleAndThumbnailUrlToItem < ActiveRecord::Migration
  def change
    add_column :items, :title, :string
    add_column :items, :thumbnail_url, :string
  end
end
