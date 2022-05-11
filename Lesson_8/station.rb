
  require_relative 'Modules/instance_counter'

  class Station
    include InstanceCounter

    attr_reader :name
    attr_accessor :trains

    @@stations = []

    def self.all
      @@stations
    end

    def initialize(name)
      @name = name
      @trains = []
      validate!
      @@stations << self
      register_instance
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    # Принимаем поезд на станцию
    def take_the_train(train)
      trains << train
    end

    # Список поездов на станции
    def train_list
      trains.each do |train|
        puts "Train number#{train.number} type #{train.type} with #{train.wagons_amount} wagons "
      end
    end

    # Список поездов на станции по типам
    def list_of_train_types
      cargo = 0
      passenger = 0
      trains.each do |train|
        if train.instance_of?(CargoTrain)
          cargo += 1
        elsif train.instance_of?(PassengerTrain)
          passenger += 1
        end
      end
      puts "freight trains #{cargo} , passenger trains #{passenger}"
    end

    # Отправляем поезд со станции
    def train_departure(train)
      trains.delete(train)
    end

    protected

    def validate!
      raise " Name can't be nil " if name.nil?
      raise ' Name has invalid format ' if name.class != String
    end
  end
