
  module OperationsWithWagons
    private

    def train_wagons_list(train)
      train_has_no_wagons(train)
      train_wagons_list!(train)
    end

    def train_wagons_list!(train)
      train.wagons_list do |elem, i|
        case elem.type
        when 'cargo'
          puts " #{i} - #{elem.number} -#{elem.type}" \
               "- Occupied volume #{elem.occupied_place} Free_volume #{elem.free_place}"
        else
          puts " #{i} - #{elem.number} -#{elem.type} " \
               "- Occupied places #{elem.occupied_place} vacancies #{elem.free_place} "
        end
      end
    end

    def select_carriage(train)
      puts 'select carriage'
      train_wagons_list(train)
      number = gets.chomp.to_i
      carriage = train.wagons[number]
      if train.wagons.include?(carriage)
        carriage
      else
        puts 'enter a valid carriage'
        select_carriage(train)
      end
    end

    def unhook_wagons(train)
      carriage = select_carriage(train)
      if !train.wagons.include?(carriage) && train.wagons.length.positive?
        unhook_wagons(train)
      elsif train.wagons.length.positive?
        train.wagon_uncoupling(carriage)
        puts "wagon #{carriage.number} is uncoupled from the train #{train.number}"
        menu
      end
    end

    def add_wagons!(train)
      puts 'enter wagon number'
      number = gets.chomp.to_i
      if train.wagon_numbers.include?(number)
        puts 'number already exists'
        add_wagons!(train)
      else
        carriage = instance_of_carriage(number, train)
        train.hitching_wagons(carriage)
      end
    end

    def add_wagons(train)
      add_wagons!(train)
      menu
    end

    def instance_of_carriage(number, train)
      if train.instance_of?(PassengerTrain)
        puts 'enter number of seats'
        number_of_seats = gets.chomp.to_i
        PassengerCarriage.new(number, number_of_seats)
      elsif train.instance_of?(CargoTrain)
        puts 'enter volume'
        volume = gets.chomp.to_i
        CargoCarriage.new(number, volume)
      end
    end

    def train_has_no_wagons(train)
      raise 'The train has no wagons' if train.wagons.length <= 0
    rescue StandardError
      puts 'The train has no wagons'
      puts 'You need to create at least one wagon'
      add_wagons!(train)
    end

    def wagon_management(train)
      train_has_no_wagons(train)
      carriage = select_carriage(train)
      begin
        carriage_volume(carriage, train)
      rescue StandardError
        volume_instance_of(train)
      end
    end

    def volume_instance_of(train)
      if train.instance_of?(CargoTrain)
        puts 'Volume busy or insufficient'
      elsif train.instance_of?(PassengerTrain)
        puts 'All places are occupied'
      end
    end

    def carriage_volume(carriage, train)
      if train.instance_of?(CargoTrain)
        puts 'enter volume'
        volume = gets.chomp.to_i
        carriage.take_a_place(volume)
        puts "Carriage #{carriage.number} accepted #{volume}"
      elsif train.instance_of?(PassengerTrain)
        carriage.take_a_place
        puts "Carriage #{carriage.number} seat is occupied"
      end
    end
  end
