class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :email
      t.boolean :is_send
      t.boolean :is_signup
      t.integer :tournament_id

      t.timestamps
    end
  end
end
