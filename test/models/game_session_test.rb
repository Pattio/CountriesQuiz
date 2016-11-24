require 'test_helper'

class GameSessionTest < ActiveSupport::TestCase
  test "can't create empty game session" do
    game_session = GameSession.new
    assert game_session.invalid?
  end


  test "create valid game session" do
    game_session = game_sessions(:one)
    assert game_session.valid?
  end
end
