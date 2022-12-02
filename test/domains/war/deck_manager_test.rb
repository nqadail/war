require 'minitest/autorun'
require 'test_helper'

module War
  class TestDeckManager < Minitest::Test

    def test_create_deck
      deck = DeckManager.create_deck
      cards = {}
      
      # ensure there are 52 cards with no dups
      deck.each do |c|
        cards[c.keys[0]] = 1 
      end

      assert_equal(cards.keys.length, 52)
    end

    def test_deal_hands
      p1 = 'one@player.com'
      p2 = 'two@player.com'
      hands = DeckManager.deal_hands(p1, p2)
      assert_equal(hands[p1].length, 26)
      assert_equal(hands[p2].length, 26)
    end

  end
end



