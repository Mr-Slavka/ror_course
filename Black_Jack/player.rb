

  class Player
  # имя , деньги, карты, очки
    attr_reader :name, :cards
    attr_accessor :points, :money
  # пропустить ход, добавить карту, открыть карты

    def initialize(name)
      @money = 100
      @cards = []
      @name = name
      @points = 0
    end

    def take_card(deck)
      @card = deck.give_card
      self.cards << @card
      self.points  += card_point(@card)
      puts "Player #{self.name} take card #{@card.value}#{@card.suit}"
      @card
    end

    def card_point(card)
          if %w[J Q K].include?(card.value)
            10
          elsif card.value == 'A' && self.points + 11 <= 21
            11
          elsif card.value == 'A' && self.points + 11 > 21
            1
          else
            card.value.to_i
          end
    end

    def show_cards
      self.cards.each { |card| print " #{card.value} #{card.suit} \n" }
    end

    def del_cards
      @cards = []
      @points = 0
    end

    def make_a_bet
      self.money -= 10
    end

    def get_money
      self.money = 100
    end
  end