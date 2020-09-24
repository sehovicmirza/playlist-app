class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :ytlink
      t.integer :votes
      t.references :playlist, index: true

      t.timestamps null: false
    end
    add_foreign_key :items, :playlists
  end
end
