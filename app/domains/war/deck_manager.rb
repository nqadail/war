module War
  class DeckManager
    SUITS = ['S', 'D', 'H', 'C']
    FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    
    class << self
      def create_deck
        deck = []
        SUITS.each do |suit|
          FACES.each_with_index do |face, i|
            deck << { (face + suit) => i }
          end 
        end
        deck
      end

      def deal_hands(player1, player2)
        deck = create_deck
        deck = deck.shuffle!
        {
          player1 => deck.values_at(*0.step(deck.size - 1, 2)),
          player2 => deck.values_at(*1.step(deck.size - 1, 2))
        }
      end
    end
  end
end