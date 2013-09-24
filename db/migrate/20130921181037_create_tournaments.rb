class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.boolean :ispairs
      t.integer :players_number
      t.date :signup_limit_date
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
