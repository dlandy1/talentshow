class AddAcceptedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :accepted, :boolean, default: false
  end
end
