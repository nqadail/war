module War
  module Handlers
    class StartGame
      class << self
        def call(data)

          playerA = data['playerA']
          playerB = data['playerB']

          userA = User.find_or_create_by(email: data['playerA'])
          userB = User.find_or_create_by(email: data['playerB'])

          hands = DeckManager::deal_hands(playerA, playerB)

          game = GameManager.new(hands).simulate_game

          win = Win.new
          win.hands_played = game['rounds']
          if game['winner'] == userA.email
            win.user_id = userA.id 
            win.opponent_user_id = userB.id 
          else
            win.user_id = userB.id 
            win.opponent_user_id = userA.id
          end
          
          win.save!

          game
        end
      end
    end
  end
end