
  require_relative 'card'

  class Deck

    VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    SUITS = ['♦', '♠', '♥ ', '♣']

    attr_reader :cards

    def initialize
      @cards = []
      VALUES.each do |value|
        SUITS.each do |suit|
          @cards << Card.new(value, suit)
        end
      end
      @cards = @cards.shuffle
    end

    def give_card
      @cards.pop
    end

  end