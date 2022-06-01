
    require_relative 'card'
    require_relative 'deck'
    require_relative 'player'
    require_relative 'dealer'
    require_relative 'game'

    puts "Welcome to blackjack game"

    Game.new.new_card_deal
