
  require_relative 'instance_counter'


  class Station


    include InstanceCounter

    attr_reader :name
    attr_accessor :trains

    @@stations = []

    def self.all
      @@stations
    end

    def initialize (name)
      @name = name
      @trains = []
      validate!
      @@stations << self
      register_instance
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    #Принимаем поезд на станцию
    def take_the_train(train)
        self.trains << train
    end

    #Список поездов на станции
    def train_list
      self.trains.each do |train|
        puts train.number
      end
    end

    #Список поездов на станции по типам
    def list_of_train_types
      cargo = 0
      passenger = 0
      self.trains.each do |train|
        if train.class == CargoTrain
          cargo += 1
        else train.class == PassengerTrain
          passenger +=1
        end
      end
      puts "freight trains #{cargo}"
      puts "passenger trains #{passenger}"
    end

    #Отправляем поезд со станции
    def train_departure(train)
      self.trains.delete(train)
    end

    protected

    def validate!
      raise " Name can't be nil "  if name.nil?
      raise " Name has invalid format " if name.class != String
    end

  end

