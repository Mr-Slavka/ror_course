
  require_relative './operations_with_wagons'
  require_relative './operations_with_stations'

  module TrainManagementMenu
    include OperationsWithWagons
    include OperationsWithStations

    TRAIN_MANAGEMENT_ITEMS = [' 1. Assign a route to a train ', ' 2. Add wagons ',
                              ' 3. Unhook wagons ', ' 4. Station ahead ',
                              ' 5. Back to the station ', ' 6. See the list of wagons '].freeze

    TRAIN_MANAGEMENT_METHODS = {
      1 => :route_to_a_train,
      2 => :add_wagons,
      3 => :unhook_wagons,
      4 => :station_forward,
      5 => :back_to_the_station,
      6 => :list_of_wagons,
      7 => :wagon_management,
      0 => :menu
    }.freeze

    def train_management_list(train)
      TRAIN_MANAGEMENT_ITEMS.each do |elem|
        puts " #{elem} "
      end
      if train.instance_of?(CargoTrain)
        puts ' 7. Volume of wagons '
      elsif train.instance_of?(PassengerTrain)
        puts ' 7. Places of wagons '
      end
      puts ' 0. Back '
      puts ' Choose an option: '
    end

    def train_management
      train = select_train
      if !@trains.include?(train)
        train_management
      else
        train_management_list(train)
        select_train_methods(train)
      end
    end

    def select_train_methods(train)
      select = gets.chomp.to_i
      if select.zero?
        send(TRAIN_MANAGEMENT_METHODS[select])
      else
        send(TRAIN_MANAGEMENT_METHODS[select], train)
      end
    rescue TypeError
      puts ' invalid input '
      retry
    end

    def list_of_trains
      @trains.each_with_index do |elem, i|
        puts " #{i} - #{elem.number} "
      end
    end

    def select_train
      puts 'Select train'
      list_of_trains
      train = @trains[gets.chomp.to_i]
      if !@trains.include?(train)
        puts 'enter a valid train'
        select_train
      else
        train
      end
    end

    def route_to_a_train(train)
      route = select_route
      if !@routes.include?(route)
        route_to_a_train(train)
      else
        train.route = (route)
        puts "Route #{route.number} added to the train #{train.number}"
        take_train_to_starting_station(train, route)
        train_management
      end
    end

    def list_of_wagons(train)
      train_wagons_list(train)
      menu
    end

  end
