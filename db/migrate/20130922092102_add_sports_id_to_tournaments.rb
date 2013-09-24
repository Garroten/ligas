class AddSportsIdToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :sport_id, :integer
  end

  def self.down
    remove_column(:tournaments, :sport_id)
  end
end
