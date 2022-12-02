require 'test_helper'
require 'test_util'

module War
  class TestGameManager < Minitest::Test
    @@fixture_data = TestUtil.load_fixture_data

    def test_simulate_game
      input = @@fixture_data['input']
      output = @@fixture_data['output']
      game = GameManager.new(input['hands']).simulate_game

      assert_equal(game['winner'], output['game']['winner'])
    end
  end
end



