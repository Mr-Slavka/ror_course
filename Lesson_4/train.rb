
  class Train

    attr_reader :number, :route
    attr_accessor :speed, :wagons, :station

    def initialize(number)
      @number = number
      @speed = 0
      @station = 0
      @wagons = []
    end

    #Задаем скорость поезду
    def set_speed(speed)
      self.speed = speed
    end

    #Останавливаем поезд
    def to_brake
      self.speed = 0
    end

    #Закрепляем маршрут
    def route=(route)
      @route = route
      self.station = route.stations[0]
      puts "The train #{self.number} arrived at the station #{self.station.name} "
    end

    #Едем на следующую станцию
    def next_station
      if route.end_station == self.station
        puts "this is the end station"
      else
        self.station = route.stations[route.stations.index(@station)+1]
        puts "The train #{self.number} arrived at the station #{self.station.name} "
      end
    end

    #Едем на предыдущую станцию
    def previous_station
      if route.starting_station == self.station
        puts "this is the first station"
      else
        self.station = route.stations[route.stations.index(@station)-1]
        puts "The train #{self.number} arrived at the station #{self.station.name} "
      end
    end

    #Возвращаем предыдущую,текущую и следующую станции
    def station_list
      puts "Route movement #{self.route.number}"
      if route.starting_station == self.station
        puts "previous station does not exist"
      else
        previous_station = route.stations[route.stations.index(@station)-1]
        puts "Previous station #{previous_station}"
      end
      puts "Current station #{self.station}"
      if route.end_station == self.station
        puts "next station does not exist"
      else
        next_station = route.stations[route.stations.index(@station)+1]
        puts "Next station #{next_station}"
      end
    end

    #Цепляем вагоны
    def hitching_wagons(wagon)
      self.wagons << wagon
    end

    #Отцепляем вагоны
    def wagon_uncoupling(wagon)
      self.wagons.delete(wagon)
      puts "wagon #{wagon.number} is uncoupled from the train #{self.number}"
    end

  end


