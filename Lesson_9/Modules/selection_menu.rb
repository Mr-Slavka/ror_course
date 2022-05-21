
  module SelectionMenu
    def selection_menu(items, methods)
      items.each do |elem|
        puts " #{elem} "
      end
      send(methods[gets.chomp.to_i])
    rescue TypeError
      puts 'invalid input'
      retry
    end
  end
