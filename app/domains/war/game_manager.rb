module War
  class Player
    attr_accessor :email, :stack

    def initialize(email,stack)
      @email = email
      @stack = stack.dup
    end 
  end

  class GameManager
    def initialize(deal)
      @hands = [] 
      @actions = []

      @deal = deal
      
      @playerA = Player.new(deal.keys[0], deal[deal.keys[0]])
      @playerB = Player.new(deal.keys[1], deal[deal.keys[1]])
      
      @cards_played = [] # per 'round'
      @game_winner = nil
    end
    
    def simulate_game
      append_action("#{playerA.email} initial deal")
      append_action(cards_list(playerA.stack))
      append_action("#{playerB.email} initial deal")
      append_action(cards_list(playerB.stack))

      round = 0
      while @game_winner.nil?
        round += 1
        @cards_played = []
        score_round
      end
      {
        'winner' => @game_winner.email,
        'rounds' => round,
        'final_stack' => cards_list(@game_winner.stack),
        'actions' => actions,
      }
    end

    private

    attr_accessor :deal, :round, :playerA, :playerB, :actions

    # Note that the War rules given do not specify the order of adding cards to 
    # winners stack

    def append_action(s)
      puts s 
      actions << s
    end

    def set_game_winner(player)
      @game_winner = player
      append_action(player.email + ' wins game!')
    end

    def cards_list(cards) 
      display = ''
      cards.each { |c| display += c.keys[0] + ' ' }
      display
    end

    def eval_hand(cardA, cardB)
      hand_winner = nil
      
      set_game_winner(playerB) if cardA.nil?
      set_game_winner(playerA) if cardB.nil?
      
      if @game_winner.nil?
        if cardA.values[0] > cardB.values[0]
          hand_winner = playerA
          append_action(
            "#{playerA.email} wins hand #{cardA.keys[0]} vs #{cardB.keys[0]}")
        elsif cardA.values[0] < cardB.values[0]
          hand_winner = playerB
          append_action(
            "#{playerB.email} wins hand #{cardB.keys[0]} vs #{cardA.keys[0]}")
        end
      end

      hand_winner 
    end

    def score_round
      cardA = playerA.stack.shift
      cardB = playerB.stack.shift

      hand_winner = eval_hand(cardA, cardB)

      @cards_played << cardA
      @cards_played << cardB

      if @game_winner.nil?
        if hand_winner.nil?
          # war ... grab 'facedown' card

          facedownA = playerA.stack.shift
          facedownB = playerB.stack.shift
          
          set_game_winner(playerB) if facedownA.nil?
          set_game_winner(playerA) if facedownB.nil?
 
          if @game_winner.nil?
            append_action("==== It's War! #{cardA.keys[0]} vs #{cardB.keys[0]}")
            append_action("#{playerA.email} puts #{facedownA.keys[0]} facedown")
            append_action("#{playerB.email} puts #{facedownB.keys[0]} facedown")
            @cards_played << facedownA
            @cards_played << facedownB
            score_round
          end
        else
          @cards_played.shuffle!

          append_action(
            "#{hand_winner.email} moves " + 
            "#{cards_list(@cards_played)} to bottom of stack"
          )
          
          @cards_played.each { |c| hand_winner.stack << c }

          append_action(
            "#{hand_winner.email} new stack: " + 
            "#{cards_list(hand_winner.stack)}"
          )
        end 
      end
    end
  end
end
