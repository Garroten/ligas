class AddFormatIdToTournaments < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :format_id, :integer
  end

  def self.down
    remove_column(:tournaments, :format_id)
  end
end
