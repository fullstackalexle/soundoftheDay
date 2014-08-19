class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :soundcloud_db_id
      t.string :title, :genre, :permalink_url
      t.integer :duration, :playback_count, :download_count, :favoritings_count, :comment_count
      t.datetime :created_at
    end
  end
end
