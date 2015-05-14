class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :url
      t.string :type

      t.timestamps
    end
  end
end
