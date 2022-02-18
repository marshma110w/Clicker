class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_digest
      #t.integer :total_score

      t.timestamps
    end
  end
end
