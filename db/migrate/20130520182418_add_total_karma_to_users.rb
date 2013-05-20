class AddTotalKarmaToUsers < ActiveRecord::Migration
  def up
    add_column :users, :total_karma, :integer, :default => 0
  end

  def down
    remove_column :users, :total_karma, :integer
  end
end
