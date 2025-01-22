class CreateHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :histories do |t|
      t.date :date
      t.decimal :lukas_value, precision: 10, scale: 2
      t.references :currency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
