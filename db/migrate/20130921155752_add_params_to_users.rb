class AddParamsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :firstname,        :string, :limit => 255, :default => '', :null => true
    add_column :users, :surname,          :string, :limit => 255, :default => '', :null => true 
    add_column :users, :gener,            :integer,               :default => 0,  :null => true
    add_column :users, :birth_date,       :date,                                  :null => true
    add_column :users, :country,          :string, :limit => 255, :default => '', :null => true
    add_column :users, :city,             :string, :limit => 255, :default => '', :null => true        
  end
  
  def self.down
    remove_column :users, :firstname
    remove_column :users, :surname
    remove_column :users, :gener
    remove_column :users, :birth_date
    remove_column :users, :country
    remove_column :users, :city
  end
end
