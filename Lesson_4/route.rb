
  class Route

    attr_reader :number, :stations, :starting_station,:end_station
    attr_accessor  :stations

    def initialize(number,starting_station,end_station )
      @number = number
      @stations = [starting_station,end_station]
      @starting_station = starting_station
      @end_station = end_station
    end

    #Добавляем промежуточную станцию
    def add_station(station)
      if self.stations.include?(station)
        puts "this station is already on the route"
      else
        self.stations.insert(1, station)
        puts "in route #{self.number}  arrived station #{station.name}"
      end
    end

    #Удаляем станцию
    def del_station(station)
      self.stations.delete(station)
        puts "delete station #{station.name} in route #{self.number}"
    end

    #Список станций в маршруте
    def station_list
      self.stations.each do |station|
        puts station.name
      end
    end
  end
