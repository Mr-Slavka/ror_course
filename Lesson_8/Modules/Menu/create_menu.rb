
  module CreateMenu
    CREATE_ITEMS = [' 1. Create station ', ' 2. Create train ',
                    ' 3. Create route ', ' 0. Back ', ' Choose an option: '].freeze

    CREATE_METHODS = {
      1 => :create_station,
      2 => :create_train,
      3 => :create_route,
      0 => :menu
    }.freeze

    CREATE_TRAIN_ITEMS = [' 1. Create cargo train ', ' 2. Create passenger train ', ' 0. Back '].freeze

    private  # скрываем методы которые доступны из пунктов меню

    def create
      selection_menu(CREATE_ITEMS, CREATE_METHODS)
    end

    def create_station
      puts 'Enter station name'
      station_name = gets.chomp.to_s
      station = Station.new(station_name)
      @stations << station
      puts "Added new station #{station.name}"
      create
    end

    def create_train
      CREATE_TRAIN_ITEMS.each do |elem|
        puts " #{elem} "
      end
      begin
        train_type(gets.chomp.to_i)
      rescue TypeError
        puts ' invalid input '
        retry
      end
    end

    def train_type(input)
      case input
      when 1
        create_train!('cargo')
      when 2
        create_train!('passenger')
      end
    end

    def create_train!(train_type)
      begin
        puts 'Enter train number'
        train = train_type_choice(train_type, gets.chomp.to_s)
      rescue StandardError
        puts 'Enter valid train number'
        retry
      end
      @trains << train
      puts "Added new train #{train.number}"
      create
    end

    def train_type_choice(train_type, train_number)
      case train_type
      when 'cargo'
        CargoTrain.new(train_number)
      when 'passenger'
        PassengerTrain.new(train_number)
      end
    end

    def add_route(number, starting_station, end_station)
      route = Route.new(number, starting_station, end_station)
      @routes << route
      puts "Add route #{route.number} Starting station #{route.starting_station.name}" \
           " End station #{route.end_station.name}"
      create
    end

    def create_route
      departure_station = select_departure_station
      end_station       = select_end_station
      if departure_station == end_station
        puts 'Dispatch station equals destination station'
        create_route
      else
        puts 'Enter route number'
        add_route(gets.chomp.to_i, departure_station, end_station)
      end
    end

    def select_departure_station
      puts 'Select departure station '
      list_of_stations
      departure_station = @stations[gets.chomp.to_i]
      if !@stations.include?(departure_station)
        puts 'enter a valid station'
      else
        puts "Add departure station#{departure_station.name}"
        departure_station
      end
    end

    def select_end_station
      puts 'Select end station '
      list_of_stations
      end_station = @stations[gets.chomp.to_i]
      if !@stations.include?(end_station)
        puts 'enter a valid station'
      else
        puts "Add departure station#{end_station.name}"
        end_station
      end
    end
  end
