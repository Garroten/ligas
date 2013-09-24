class AddNameToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :name, :string
    add_column :candidates, :cancel, :boolean
    add_column :candidates, :user_id, :integer
  end
end
