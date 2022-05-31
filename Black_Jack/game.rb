
  require_relative 'card'
  require_relative 'deck'
  require_relative 'player'
  require_relative 'dealer'
  require_relative 'Modules/selection_menu'



    class Game

      include SelectionMenu

      attr_reader :player, :dialer, :bank,:round, :deck


      def initialize
        print 'Введите ваше имя:'
        @player = Player.new(gets.chomp)
        @dealer = Dealer.new('dealer')
        @bank = 0
        @round = 0
      end

      MENU_TWO_CARDS_ITEMS = [' ------------------------- ', ' What do you want to do ? ',
                    ' 1. Get another card', ' 2. Skip a turn ',
                    ' 3. Show down ',
                    ' 0. Exit ', ' Choose an option: '].freeze

      MENU_TWO_CARDS_METHODS = {
        1 => :player_take_card,
        2 => :skip_a_turn,
        3 => :open_cards,
        0 => :exit
      }.freeze

      MENU_MORE_TWO_CARDS_ITEMS = [' ------------------------- ', ' What do you want to do ? ', ' 1. Skip a turn ',
                              ' 2. Show down ',
                              ' 0. Exit ', ' Choose an option: '].freeze


      MENU_MORE_TWO_CARDS_METHODS = {
        1 => :skip_a_turn,
        2 => :open_cards,
        0 => :exit
      }.freeze

      NEXT_ROUND_MENU_ITEMS  = [' ------------------------- ', ' Play again ? ', ' 1. Yes ',
                              ' 0. Exit ', ' Choose an option: '].freeze

      NEXT_ROUND_MENU_METHODS = {
        1 => :new_card_deal,
        0 => :exit
      }.freeze

      def choice_menu
        show_cards(@player)
        if @player.cards.count == 2
          menu_two_cards
        else
          menu_more_two_cards
        end
      end

      def next_round_menu
        selection_menu(NEXT_ROUND_MENU_ITEMS, NEXT_ROUND_MENU_METHODS)
      end


      def menu_two_cards
        selection_menu(MENU_TWO_CARDS_ITEMS, MENU_TWO_CARDS_METHODS)
      end

      def menu_more_two_cards
        selection_menu(MENU_MORE_TWO_CARDS_ITEMS, MENU_MORE_TWO_CARDS_METHODS)
      end

      def show_cards(player)
        puts "#{player.name} cards"
        player.show_cards
        puts "#{player.name} points"
        puts player.points
      end

      def place_bets
        @player.make_a_bet
        @dealer.make_a_bet
        @bank += 20
      end

      def new_card_deal
        puts " Сard deal № #{@round += 1}"
        @deck = Deck.new
        place_bets
        @player.del_cards
        @dealer.del_cards
        2.times do
          @player.take_card(@deck)
          @dealer.take_card(@deck)
        end
        choice_menu
      end

      def player_take_card
        @player.take_card(@deck)
        show_cards(@player)
        dealer_s_turn
      end

      def skip_a_turn
        puts "Player #{@player.name} skip a turn "
        dealer_s_turn
      end

      def dealer_s_turn
        @dealer.take_card(@deck)
        puts "Dealer cards"
        @dealer.cards.each do print " * \n"
        self.open_cards if @dealer.cards.count == 3 && @player.cards.count == 3
        choice_menu
        end
      end

      def open_cards
        puts  "Open cards"
        processing_final_cards
      end

      def processing_final_cards
        puts "-----Round over-----"
        show_cards(@player)
        show_cards(@dealer)
        counting_points(@player.points, @dealer.points)
        check_money
        reset_bank
        next_round_menu
      end

      def reset_bank
        @bank = 0
      end

      def counting_points(player_points, dealer_points)
         if player_points > 21 && dealer_points < 21 || (dealer_points <= 21 && player_points < dealer_points)
           player_lost
         elsif dealer_points > 21 && player_points <=21|| (dealer_points < 21 && player_points > dealer_points)
           player_win
         elsif player_points > 21 && dealer_points > 21 || player_points == dealer_points
           draw
         end
      end

      def  player_lost
        @dealer.money += @bank
        puts "Player #{@player.name} lost the round "
      end

      def  player_win
        @player.money += @bank
        puts "Player #{@player.name} win the round "
      end

      def  draw
        @dealer.money += @bank/2
        @player.money += @bank/2
        puts "Draw"
      end

      def check_money
          puts "Player #{@player.name} money #{@player.money}"
          puts "Dealer money #{@dealer.money}"
        if @player.money < 10
          puts "You no longer have money to bet"
          restart_menu
        elsif @dealer.money < 10
          puts "You won"
          restart_menu
        end
      end

      def restart_menu
        puts "1.Restart game"
        puts "0.Exit_game"
        case gets.chomp.to_i
        when 1
          restart_game
        when 0
          exit
        end
      end

      def restart_game
        puts "Restart_game"
        @round = 0
        @dealer.get_money
        @player.get_money
        new_card_deal
      end
    end
