class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.string :question, limit: 255
      t.text :reply, limit: 99_999

      t.timestamps
    end
  end
end
