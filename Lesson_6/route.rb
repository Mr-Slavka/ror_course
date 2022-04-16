
  require_relative 'instance_counter'


  class Route

    include InstanceCounter

    attr_reader :number, :stations, :starting_station,:end_station
    attr_accessor  :stations

    def initialize(number,starting_station,end_station )
      @number = number
      @stations = [starting_station,end_station]
      @starting_station = starting_station
      @end_station = end_station
      register_instance
      validate!
    end

    def valid?
      validate!
      true
    rescue
      false
    end



    #Добавляем промежуточную станцию
    def add_station(station)
        self.stations.insert(1, station)
    end

    #Удаляем станцию
    def del_station(station)
      self.stations.delete(station)
    end

    #Список станций в маршруте
    def station_list
      self.stations.each do |station|
        puts station.name
      end
    end


    protected

    def validate!
      raise " Number can't be nil "  if number.nil?
      raise " Number has invalid format " if number.class != Integer
      raise " Starting_station is not a Station class" if starting_station.class != Station
      raise " End_station is not a Station class" if end_station.class != Station
    end

  end
