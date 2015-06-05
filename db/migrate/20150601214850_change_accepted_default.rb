class ChangeAcceptedDefault < ActiveRecord::Migration
  def change
    change_column :posts, :accepted, :boolean, default: nil
  end
end
