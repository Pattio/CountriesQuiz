class AddQuestionUnitToGameSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :game_sessions, :QuestionUnit, :string
  end
end
