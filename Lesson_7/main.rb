
  require_relative 'train'
  require_relative 'passenger_train'
  require_relative 'passenger_carriage'
  require_relative 'cargo_train'
  require_relative 'cargo_carriage'
  require_relative 'route'
  require_relative 'station'
  require_relative 'carriage'
  require_relative 'manufacturer'
  require_relative 'instance_counter'



  class Main

    attr_reader :stations, :trains, :routes

    def initialize

      @stations = []
      @trains =[]
      @routes =[]
    end

    def seed
      @stations = [Station.new("First"), Station.new("Second"), Station.new("Third")]
      @routes = [Route.new(1,@stations.first, @stations[1]), Route.new(2,@stations[1], @stations.last)]
      @trains = [CargoTrain.new("001-hh"), PassengerTrain.new("002-hh")]
    end


    def menu

    loop do
      puts " What do you want to do "
      puts "1. Create (station, train, route)"
      puts "2. Route management (add/remove station)"
      puts "3. Train management (Assign a route to a train, add/unhook wagons, move a train along a route)"
      puts "4. View the list of stations and the list of trains in the station"
      puts "0. Exit"
      puts "Choose an option: "

      input = gets.chomp.to_i

      case input
        when 1
          create
        when 2
          route_management
        when 3
          train_management
        when 4
          list
        when 0
          break
        else
        puts "invalid input"
      end
     end
    end

    private  # скрываем методы которые доступны из пунктов меню

    def create

      loop do
        puts "1. Create station "
        puts "2. Create train"
        puts "3. Create route"
        puts "0. Back"
        puts "Choose an option: "

        input = gets.chomp.to_i

        case input
        when 1
          create_station
        when 2
          create_train
        when 3
          create_route
        when 0
          break
        else
          puts "invalid input"
        end
      end
    end

    def route_management

      loop do
        puts "1. Add station "
        puts "2. Remove station "
        puts "0. Back"
        puts "Choose an option: "

        input = gets.chomp.to_i

        case input
        when 1
          add_station_to_route
        when 2
          remove_station_from_route
        when 0
          break
        else
          puts "invalid input"
        end
      end
    end

    def train_management

      train = select_train
      if ! @trains.include?(train)
        train_management
      else
        loop do
        puts "1. Assign a route to a train"
        puts "2. Add wagons"
        puts "3. Unhook wagons"
        puts "4. Station ahead"
        puts "5. Back to the station"
        puts "6. See the list of wagons"
        if train.class == CargoTrain
           puts "7. Volume of wagons"
        elsif   train.class == PassengerTrain
           puts "7. Places of wagons"
        end
        puts "0. Back"
        puts "Choose an option: "

        input = gets.chomp.to_i

        case input
        when 1
          route_to_a_train(train)
        when 2
          add_wagons(train)
        when 3
          unhook_wagons(train)
        when 4
          station_forward(train)
        when 5
          back_to_the_station(train)
        when 6
          train_wagons_list(train)
        when 7
           wagon_management(train)
        when 0
          break
        else
          puts "invalid input"
        end
       end
      end
    end

    def list

      loop do
        puts "1. List of stations"
        puts "2. List of trains in the station"
        puts "0. Back"
        puts "Choose an option: "

        input = gets.chomp.to_i

        case input
        when 1
          list_of_stations
        when 2
          list_of_trains_in_the_station
        when 0
          break
        else
          puts "invalid input"
        end
      end
    end

    def create_station

      puts "Enter station name"
      station_name = gets.chomp.to_s
      station = Station.new(station_name)
      @stations << station
      puts "Added new station #{station.name}"

    end

    def create_train
      loop do
        puts "1. Create cargo train "
        puts "2. Create passenger train"
        puts "0. Back"

        input = gets.chomp.to_i


        case input
        when 1
          create_train!("cargo")
        when 2
          create_train!("passenger")
        when 0
          break
        else
          puts "invalid input"
        end
      end
    end

    def create_train!(train_type)
      begin
      puts "Enter train number"
      train_number = gets.chomp.to_s
      if train_type == "cargo"
        train = CargoTrain.new(train_number)
        else train_type == "passenger"
      train = PassengerTrain.new(train_number)
      end
      rescue
        puts "Enter valid train number"
        retry
      end
      @trains << train
      puts "Added new train #{train.number}"

    end

    def list_of_stations
      @stations.each_with_index do |elem, i|
        puts  " #{i} - #{elem.name} "
      end
    end

    def add_route(number,starting_station,end_station)
        route = Route.new(number,starting_station,end_station)
        @routes << route
        puts "Add route #{route.number} Starting station #{route.starting_station.name}
              End station #{route.end_station.name}"
    end

    def create_route
        puts "Enter route number"
      route_number = gets.chomp.to_i
        puts "Select departure station "
        list_of_stations
      index = gets.chomp.to_i
      departure_station = @stations[index]
        if ! @stations.include?(departure_station)
          puts "enter a valid station"
        else
          puts "Add departure station#{departure_station.name}"
          puts "Select end station "
          list_of_stations
      index_end_station = gets.chomp.to_i
      end_station = @stations[index_end_station]
        if departure_station == end_station
         puts "Dispatch station equals destination station"
        elsif ! @stations.include?(end_station)
         puts "enter a valid station"
        else
         puts "Add end station #{end_station.name}"
         add_route(route_number, departure_station, end_station)
        end
        end
    end

    def list_of_routs
      @routes.each_with_index do |elem, i|
        puts  " #{i} - #{elem.number}  #{elem.starting_station.name}  ----   #{elem.end_station.name}"
      end
    end

    def select_route
      puts "Select route"
      list_of_routs
      input = gets.chomp.to_i
      route = @routes[input]
      if ! @routes.include?(route)
        puts "enter a valid route"
      else
        puts "route #{route.number} selected"
      end
        route
    end

    def select_station
      puts  "Select station"
      list_of_stations
      station_input = gets.chomp.to_i
      station = @stations[station_input]
      if ! @stations.include?(station)
        puts "enter a valid station"
      else
        return station
      end
    end

    def  add_station_to_route
      route =  select_route
      if ! @routes.include?(route)
        add_station_to_route
      else
        station = select_station
        if ! @stations.include?(station)
          select_station
        elsif route.stations.include?(station)
          puts "this station is already on the route"
        else
          route.add_station(station)
          puts "in route #{route.number}  arrived station #{station.name}"
        end
      end
    end

    def list_station_in_route(route)
      route.stations.each_with_index do |elem, i|
        puts  " #{i} - #{elem.name} "
      end
    end

    def select_route_station(route)
      puts  "Select station"
      list_station_in_route(route)
      station_input = gets.chomp.to_i
      station = route.stations[station_input]
      if ! route.stations.include?(station)
        puts "enter a valid station"
      else
        return station
      end
    end

    def  remove_station_from_route
      route =  select_route
      if route.stations.length <= 2
        puts "Few stations on the route"
      else
        if ! @routes.include?(route)
          remove_station_from_route
        else
          station = select_route_station(route)
          if ! route.stations.include?(station)
            select_route_station(route)
          else
            route.del_station(station)
            puts "delete station #{station.name} in route #{route.number}"
          end
         end
      end
    end

    def list_of_trains
      @trains.each_with_index do |elem, i|
        puts  " #{i} - #{elem.number} "
      end
    end

    def select_train
      puts  "Select train"
      list_of_trains
      train_input = gets.chomp.to_i
      train = @trains[train_input]
      if ! @trains.include?(train)
        puts "enter a valid train"
      else
        return train
      end
    end

    def route_to_a_train(train)
      route =  select_route
      if ! @routes.include?(route)
        route_to_a_train(train)
      else
        train.route=(route)
        station = @stations[@stations.index(route.starting_station)]
        station.take_the_train(train)
        puts "Route #{route.number} added to the train #{train.number}"
        puts "The train #{train.number} arrived at the station #{route.starting_station.name} "
      end
    end

    def add_train_to_station(train)
         station = train.station
      if ! station.trains.include?(train)
         station.take_the_train(train)
         puts "in station #{station.name}  arrived train #{train.number}"
      else
         puts " #{train.number} already at the station #{station.name}"
      end
    end

    def station_forward(train)
      if train.route.nil?
        puts " Train #{train.number} not on route"
      else
        if train.route.end_station == train.route.stations[train.route.stations.index(train.station)]
           puts "this is the end station"
        else
           train.next_station
           add_train_to_station(train)
           past_station = train.route.stations[train.route.stations.index(train.station)-1]
           past_station.train_departure(train)
           puts "train #{train.number} departure station #{past_station.name}"
        end
      end
    end

    def back_to_the_station(train)
      if train.route.nil?
        puts " Train #{train.number} not on route"
      else

        if train.route.starting_station == train.route.stations[train.route.stations.index(train.station)]
          puts "this is the first station"
        else
          train.previous_station
          add_train_to_station(train)
          next_station = train.route.stations[train.route.stations.index(train.station)+1]
          next_station.train_departure(train)
          puts "train #{train.number} departure station #{next_station.name}"
        end
      end
    end

    def train_wagons_list(train)
      train.wagons_list
    end

    def select_carriage(train)
      puts "select carriage"
      train_wagons_list(train)
      number = gets.chomp.to_i
      carriage = train.wagons[number]
      if train.wagons.include?(carriage)
        return carriage
      elsif train.wagons.length <= 0
        puts "The train has no wagons"
      else
        puts "enter a valid carriage"
        select_carriage(train)
      end

    end

    def unhook_wagons(train)
      carriage = select_carriage(train)
      if ! train.wagons.include?(carriage) && train.wagons.length > 0
        unhook_wagons(train)
      elsif train.wagons.length > 0
        train.wagon_uncoupling(carriage)
        puts "wagon #{carriage.number} is uncoupled from the train #{train.number}"
      end
    end

    def add_wagons(train)
      puts "enter wagon number"
      number = gets.chomp.to_i
      if train.wagon_numbers.include?(number)
        puts "number already exists"
        else
      if train.class == PassengerTrain
        puts "enter number of seats"
        number_of_seats = gets.chomp.to_i
        carriage = PassengerCarriage.new(number,number_of_seats)
      elsif train.class == CargoTrain
        puts "enter volume"
        volume = gets.chomp.to_i
        carriage = CargoCarriage.new(number,volume)
      end
        train.hitching_wagons(carriage)
        puts "wagon #{carriage.number} attached to the train #{train.number}"
      end
    end

    def wagon_management(train)
      begin
        raise  "The train has no wagons" if train.wagons.length <= 0
      rescue
        puts "You need to create at least one wagon"
        add_wagons(train)
      end
        carriage = select_carriage(train)
      begin
        if train.class == CargoTrain
          puts "enter volume"
          volume = gets.chomp.to_i
          carriage.take_a_volume(volume)
          puts "Carriage #{carriage.number} accepted #{volume}"
        elsif train.class == PassengerTrain
          carriage.take_the_place
          puts "Carriage #{carriage.number} seat is occupied"
        end
      rescue
        if train.class == CargoTrain
          puts "Volume busy or insufficient"
        elsif train.class == PassengerTrain
          puts "All places are occupied"
        end
      end
    end

    def list_of_trains_in_the_station
      station = select_station
      if  station.trains.length > 0
        station.train_list
      else
        puts "there are no trains at the station"
      end

    end
  end




