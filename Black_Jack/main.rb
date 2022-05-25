
  require_relative 'card'
  require_relative 'deck'
  require_relative 'player'
  require_relative 'dealer'
  require_relative 'Modules/selection_menu'



    class Main

      include SelectionMenu


      def initialize
        print 'Введите ваше имя:'
        @player = Player.new(gets.chomp)
        @dialer = Dealer.new('dealer')
        @bank = 0
      end


      def menu

      end
    end