
  require_relative 'train'
  require_relative 'passenger_train'
  require_relative 'passenger_carriage'
  require_relative 'cargo_train'
  require_relative 'cargo_carriage'
  require_relative 'route'
  require_relative 'station'
  require_relative 'carriage'
  require_relative 'Modules/manufacturer'
  require_relative 'Modules/instance_counter'
  require_relative 'Modules/selection_menu'
  require_relative 'Modules/Menu/create_menu'
  require_relative 'Modules/Menu/route_management_menu'
  require_relative 'Modules/Menu/train_management/train_management_menu'

  class Main
    include SelectionMenu
    include CreateMenu
    include RouteManagementMenu
    include TrainManagementMenu

    attr_reader :stations, :trains, :routes

    def initialize
      @stations = []
      @trains = []
      @routes = []
    end

    MENU_ITEMS = [' ------------------------- ', ' What do you want to do ? ',
                  ' 1. Create (station, train, route)', ' 2. Route management (add/remove station) ',
                  ' 3. Train management (Assign a route to a train, add/unhook wagons, move a train along a route) ',
                  ' 4. View the list of stations and the list of trains in the station ',
                  ' 0. Exit ', ' Choose an option: '].freeze

    MENU_METHODS = {
      1 => :create,
      2 => :route_management,
      3 => :train_management,
      4 => :list,
      0 => :exit
    }.freeze

    LIST_ITEMS = [' 1. List of stations ', ' 2. List of trains in the station ', ' 0. Back ',
                  ' Choose an option: '].freeze

    LIST_METHODS = {
      1 => :list_of_stations,
      2 => :list_of_trains_in_the_station,
      0 => :menu
    }.freeze

    def seed
      @stations = [Station.new('First'), Station.new('Second'), Station.new('Third')]
      @routes = [Route.new(1, @stations.first, @stations[1]), Route.new(2, @stations[1], @stations.last)]
      @trains = [CargoTrain.new('001-hh'), PassengerTrain.new('002-hh')]
    end

    def menu
      selection_menu(MENU_ITEMS, MENU_METHODS)
    end

    private  # скрываем методы которые доступны из пунктов меню

    def list
      selection_menu(LIST_ITEMS, LIST_METHODS)
    end

    def list_of_stations
      @stations.each_with_index do |elem, i|
        puts " #{i} - #{elem.name} "
      end
    end

    def list_of_trains_in_the_station
      station = select_station
      if station.trains.length.positive?
        station.train_list
      else
        puts 'there are no trains at the station'
        list
      end
    end
  end
