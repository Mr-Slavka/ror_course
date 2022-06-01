
  class Dealer < Player

    def initialize(name)
      super (name)
    end

    def take_card(deck)
      if self.points < 17 && self.cards.count < 3
        puts  "Dealer takes a card"
      @card = deck.give_card
      self.cards << @card
      self.points += card_point(@card)
      else
        puts "Dealer skips a turn"
      end
    end
  end