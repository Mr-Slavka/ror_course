
  require_relative 'card'
  require_relative 'deck'
  require_relative 'player'
  require_relative 'dealer'
  require_relative 'Modules/selection_menu'



    class Main

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

      def choice_menu
        show_cards(@player)
        if @player.cards.count == 2
          menu_two_cards
        else
          menu_more_two_cards
        end
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
        self.open_cards if @dealer.cards.count == 3 && @player.cards.count == 3
        puts "Dealer cards"
        @dealer.cards.each do print " * \n"
        choice_menu
        end
      end

      def open_cards
        puts  "Open cards"
        processing_final_cards
      end

      def processing_final_cards
        show_cards(@player)
        show_cards(@dealer)

      end
    end
