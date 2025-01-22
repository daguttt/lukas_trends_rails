class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      # t.string :full_name, limit: 80
      # t.string :password, limit: 70
      # t.string :email, limit: 100
      t.integer :subscription_type
      t.integer :role
      t.json :preferences

      t.timestamps
    end
  end
end
