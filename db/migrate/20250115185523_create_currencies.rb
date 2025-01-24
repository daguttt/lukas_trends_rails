class CreateCurrencies < ActiveRecord::Migration[7.2]
  def change
    create_table :currencies do |t|
      t.string :name, limit: 30

      t.timestamps
    end
    add_index :currencies, :name, unique: true
  end
end
