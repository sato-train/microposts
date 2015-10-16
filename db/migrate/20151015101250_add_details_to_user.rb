class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_column :users, :place, :string
    add_column :users, :url, :string
    add_column :users, :birthday, :datetime
  end
end
