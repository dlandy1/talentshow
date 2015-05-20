class AddArtistToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :artist_id, :integer
    add_index :posts, :artist_id
  end
end
