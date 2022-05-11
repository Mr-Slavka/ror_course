require_relative 'Modules/manufacturer'
require_relative 'Modules/instance_counter'

class Train
  include InstanceCounter
  include Manufacturer

  attr_reader :number, :route, :wagons_amount
  attr_accessor :speed, :wagons, :station, :wagon_numbers

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
    @wagon_numbers = []
    validate!
    @@trains << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def wagons_list(&block)
    wagons.each_with_index(&block)
  end

  # Задаем скорость поезду
  def speed!(speed)
    self.speed = speed
  end

  # Останавливаем поезд
  def to_brake
    self.speed = 0
  end

  # Закрепляем маршрут
  def route=(route)
    @route = route
    self.station = route.stations[0]
  end

  # Едем на следующую станцию
  def next_station
    self.station = route.stations[route.stations.index(@station) + 1]
  end

  # Едем на предыдущую станцию
  def previous_station
    self.station = route.stations[route.stations.index(@station) - 1]
  end

  # Возвращаем предыдущую,текущую и следующую станции
  def station_list
    if route.nil?
      puts " Train #{number} not on route"
    else
      puts "Route movement #{route.number}"
      list_previous_station
      puts "Current station #{station}"
      list_next_station
    end
  end

  def list_previous_station
    if route.starting_station == station
      puts 'previous station does not exist'
    else
      previous_station = route.stations[route.stations.index(@station) - 1]
      puts "Previous station #{previous_station}"
    end
  end

  def list_next_station
    if route.end_station == station
      puts 'next station does not exist'
    else
      next_station = route.stations[route.stations.index(@station) + 1]
      puts "Next station #{next_station}"
    end
  end

  # Цепляем вагоны
  def hitching_wagons(wagon)
    wagons << wagon
    @wagons_amount += 1
    wagon_numbers << wagon.number
    puts "wagon #{wagon.number} attached to the train #{number}"
  end

  # Отцепляем вагоны
  def wagon_uncoupling(wagon)
    wagons.delete(wagon)
    @wagons_amount -= 1
    wagon_numbers.delete(wagon.number)
  end

  protected

  def validate!
    raise " Number can't be nil " if number.nil?
    raise ' Number has invalid format ' if number !~ /[a-zа-я\d]{3}-?[a-zа-я\d]{2}/i
  end
end
