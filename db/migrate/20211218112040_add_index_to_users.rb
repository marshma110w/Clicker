class AddIndexToUsers < ActiveRecord::Migration[6.1]
  def change
    #add_column :users, :login, :string
    add_index :users, :login, unique: true
    add_column :users, :total_score, :integer, :null => false, :default => 0
    add_column :users, :level, :integer, :null => false, :default => 1
  end
end
