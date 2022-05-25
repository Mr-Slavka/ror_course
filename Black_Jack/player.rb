

  class Player
  # имя , деньги, карты, очки
    attr_reader :name, :cards, :money, :points

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
      self.points += card_point(@card)
    end

    def card_point(card)
      self.points = if %w[J Q K].include?(card.value)
            10
          elsif card.value == 'A' || self.points + 11 <= 21
            11
          elsif card.value == 'A' || self.points + 11 > 21
            1
          else
            card.value.to_i
          end
    end

    def show_card
      self.cards.each { |card| print " #{card.value} #{card.suit} " }
    end

    def del_cards
      @cards = []
      @points = 0
    end
  end