
  require_relative 'Modules/instance_counter'
  require_relative 'Modules/validation'
  require_relative 'Modules/acсessors'
  require_relative 'station'

  class Route

    include InstanceCounter
    include Validation
    extend Accessors

    attr_reader :number, :starting_station, :end_station
    attr_accessor :stations

    strong_attr_accessor :station

    validate :number, :validation_type, Integer
    validate :number, :presence
    validate :starting_station, :validation_type, Station
    validate :end_station, :validation_type, Station

    def initialize(number, starting_station, end_station)
      @number = number
      @stations = [starting_station, end_station]
      @starting_station = starting_station
      @end_station = end_station
      validate!
      register_instance
    end


    # Добавляем промежуточную станцию
    def add_station(station)
      set_station(station, Station)
      @station = station
      stations.insert(1, station)
    end

    # Удаляем станцию
    def del_station(station)
      stations.delete(station)
    end

    # Список станций в маршруте
    def station_list
      stations.each do |station|
        puts station.name
      end
    end

  end
