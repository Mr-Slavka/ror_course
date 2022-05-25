
# деньги, карты, очки
# пропустить ход, добавить карту

  class Dealer < Player

    def initialize(name)
      super (name)
    end

    def show_card
      self.cards.each { |card| print " *** " }
    end

  end