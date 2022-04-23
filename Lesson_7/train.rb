
  require_relative 'manufacturer'
  require_relative 'instance_counter'

  class Train

    include Manufacturer, InstanceCounter

    attr_reader :number, :route, :wagons_amount
    attr_accessor :speed, :wagons, :station,:wagon_numbers

    @@trains = []

    def self.find(number)
      @@trains.find { |train| train.number == number }
    end

    def initialize(number)
      @number = number
      @speed = 0
      @station = 0
      @wagons = []
      @wagons_amount = 0
      @wagon_numbers =[]
      validate!
      @@trains << self
      register_instance
    end

    def valid?
      validate!
      true
    rescue
      false
    end


    def wagons_list
      if self.wagons.length <= 0
        puts "The train has no wagons"
      else
        self.wagons.each_with_index do |elem, i|
          if elem.type == "cargo"
            puts " #{i} - #{elem.number} -#{elem.type} - Occupied volume #{elem.occupied_volume} Free_volume #{elem.free_volume}"
          elsif elem.type == "passenger"
            puts " #{i} - #{elem.number} -#{elem.type} - Occupied places #{elem.occupied_places} vacancies #{elem.vacancies} "
          end
       end
      end
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
    end

    #Едем на следующую станцию
    def next_station
        self.station = route.stations[route.stations.index(@station)+1]
    end

    #Едем на предыдущую станцию
    def previous_station
        self.station = route.stations[route.stations.index(@station)-1]
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
      @wagons_amount += 1
      self.wagon_numbers << wagon.number
    end

    #Отцепляем вагоны
    def wagon_uncoupling(wagon)
      self.wagons.delete(wagon)
      @wagons_amount -= 1
      self.wagon_numbers.delete(wagon.number)
    end


    protected

    def validate!
      raise " Number can't be nil "  if number.nil?
      raise " Number has invalid format " if number !~ /[a-zа-я\d]{3}-?[a-zа-я\d]{2}/i
    end

  end


