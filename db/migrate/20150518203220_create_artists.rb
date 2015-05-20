class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.references :user, index: true
      t.timestamps
    end
  end
end
