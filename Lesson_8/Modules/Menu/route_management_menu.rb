
  module RouteManagementMenu
    ROUTE_MANAGEMENT_ITEMS = [' 1. Add station ', ' 2. Remove station ', ' 0. Back ', ' Choose an option: '].freeze

    ROUTE_MANAGEMENT_METHODS = {
      1 => :add_station_to_route,
      2 => :remove_station_from_route,
      0 => :menu
    }.freeze

    private

    def route_management
      selection_menu(ROUTE_MANAGEMENT_ITEMS, ROUTE_MANAGEMENT_METHODS)
    end

    def list_of_routs
      @routes.each_with_index do |elem, i|
        puts " #{i} - #{elem.number}  #{elem.starting_station.name}  ----   #{elem.end_station.name}"
      end
    end

    def select_route
      puts 'Select route'
      list_of_routs
      input = gets.chomp.to_i
      route = @routes[input]
      if !@routes.include?(route)
        puts 'enter a valid route'
      else
        puts "route #{route.number} selected"
      end
      route
    end

    def select_station
      puts 'Select station'
      list_of_stations
      station = @stations[gets.chomp.to_i]
      if !@stations.include?(station)
        puts 'enter a valid station'
        select_station
      else
        station
      end
    end

    def add_station_to_route
      route = select_route
      if !@routes.include?(route)
        add_station_to_route
      else
        station = select_station
        add_station_to_route!(route, station)
        route_management
      end
    end

    def  add_station_to_route!(route, station)
      if !@stations.include?(station)
        select_station
      elsif route.stations.include?(station)
        puts 'this station is already on the route'
        select_station
      else
        route.add_station(station)
        puts "in route #{route.number}  arrived station #{station.name}"
      end
    end

    def list_station_in_route(route)
      route.stations.each_with_index do |elem, i|
        puts " #{i} - #{elem.name} "
      end
    end

    def select_route_station(route)
      puts 'Select station'
      list_station_in_route(route)
      station = route.stations[gets.chomp.to_i]
      if !route.stations.include?(station)
        puts 'enter a valid station'
        select_route_station(route)
      else
        station
      end
    end

    def remove_station_from_route
      route =  select_route
      if route.stations.length <= 2
        puts 'Few stations on the route'
      elsif !@routes.include?(route)
        remove_station_from_route
      else
        station = select_route_station(route)
        delete_station(station, route)
      end
    end

    def delete_station(station, route)
      route.del_station(station)
      puts "delete station #{station.name} in route #{route.number}"
      route_management
    end
  end
