class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.boolean :ispairs
      t.integer :playernumber

      t.timestamps
    end
  end
end
