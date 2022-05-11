
  module OperationsWithStations
    private

    def take_train_to_starting_station(train, route)
      station = @stations[@stations.index(route.starting_station)]
      station.take_the_train(train)
      puts "The train #{train.number} arrived at the station #{route.starting_station.name} "
    end

    def add_train_to_station(train)
      station = train.station
      if !station.trains.include?(train)
        station.take_the_train(train)
        puts "in station #{station.name}  arrived train #{train.number}"
      else
        puts " #{train.number} already at the station #{station.name}"
      end
    end

    def station_forward(train)
      if train.route.nil?
        puts " Train #{train.number} not on route"
        train_management
      elsif this_is_the_end_station?(train)
        puts 'this is the end station'
        train_management
      else
        station_forward!(train)
      end
    end

    def this_is_the_end_station?(train)
      true if train.route.end_station == train.route.stations[train.route.stations.index(train.station)]
    end

    def station_forward!(train)
      train.next_station
      add_train_to_station(train)
      past_station_train_departure(train)
      train_management
    end

    def past_station_train_departure(train)
      past_station = train.route.stations[train.route.stations.index(train.station) - 1]
      past_station.train_departure(train)
      puts "train #{train.number} departure station #{past_station.name}"
    end

    def back_to_the_station(train)
      if train.route.nil?
        puts " Train #{train.number} not on route"
        train_management
      elsif this_is_the_first_station?(train)
        puts 'this is the first station'
        train_management
      else
        back_to_the_station!(train)
      end
    end

    def this_is_the_first_station?(train)
      true if train.route.starting_station == train.route.stations[train.route.stations.index(train.station)]
    end

    def back_to_the_station!(train)
      train.previous_station
      add_train_to_station(train)
      next_station_train_departure(train)
      train_management
    end

    def next_station_train_departure(train)
      next_station = train.route.stations[train.route.stations.index(train.station) + 1]
      next_station.train_departure(train)
      puts "train #{train.number} departure station #{next_station.name}"
    end
  end
