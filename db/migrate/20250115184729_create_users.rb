class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.integer :subscription_type
      t.integer :role
      t.json :preferences

      t.timestamps
    end
  end
end
