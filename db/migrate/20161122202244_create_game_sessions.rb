class CreateGameSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :game_sessions do |t|
      t.text :Question
      t.integer :Score
      t.integer :Answer
      t.text :Options
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
