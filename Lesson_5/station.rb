
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
      @@stations << self
      register_instance
    end

    #Принимаем поезд на станцию
    def take_the_train(train)
      if ! self.trains.include?(train)
        self.trains << train
        puts "in station #{self.name}  arrived train #{train.number}"
      else
        puts " #{train.number} already at the station #{self.name}"
      end
    end

    #Список поездов на станции
    def train_list
      if  self.trains.length > 0
      self.trains.each do |train|
        puts train.number
      end
      else
        puts "there are no trains at the station"
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
      puts "train #{train.number} departure station #{self.name}"
    end
  end

