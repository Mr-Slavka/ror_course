
   class Station

     attr_reader :name

     def initialize (name)
       @name = name
       @trains = []
     end

     #Принимаем поезд на станцию
     def take_the_train(train)
       if ! @trains.include?(train)
         @trains << train
         puts "in station #{self.name}  arrived train #{train.number}"
       else
         puts " #{train.number} already at the station #{self.name}"
       end
     end

     #Список поездов на станции
     def train_list
       @trains.each do |train|
         puts train.number
       end
     end

     #Список поездов на станции по типам
     def list_of_train_types
        cargo = 0
        passenger = 0
        @trains.each do |train|
         if train.type == "cargo"
           cargo += 1
         else train.type == "passenger"
         passenger +=1
         end
       end
        puts "freight trains #{cargo}"
        puts "passenger trains #{passenger}"
     end

     #Отправляем поезд со станции
     def train_departure(train)
       @trains.delete(train)
        puts "train #{train.number} departure station #{self.name}"
     end
   end


   class Train

     attr_reader :type, :speed, :wagons_count, :number, :route , :station


     def initialize(number, type, wagons_count)
       #passenger - Пассажирский; cargo - Грузовой
       @number = number
       @type = type
       @wagons_count = wagons_count
       @speed = 0
       @station = 0
     end

     #Задаем скорость поезду
     def set_speed(speed)
       @speed = speed
     end

     #Останавливаем поезд
     def to_brake
       @speed = 0
     end

     #Цепляем вагоны
     def hitching_wagons
       if @speed == 0
         @wagons_count+=1
         puts "one wagon connected , at the train #{self.number} of #{@wagons_count} wagons"
       else
         puts " to attach the wagon you need to stop "
       end
     end

     #Отцепляем вагоны
     def wagon_uncoupling
       if @speed == 0
         @wagons_count-=1
         puts "one wagon disconnected , at the train #{self.number} of #{@wagons_count} wagons"
       else
         puts " to unhook the carriage you need to stop "
       end
     end

     #Закрепляем маршрут
     def route=(route)
       @route = route
       @station = route.stations[0]
     end

     #Едем на следующую станцию
     def next_station
       if route.end_station == @station
         puts "this is the end station"
       else
         @station = route.stations[route.stations.index(@station)+1]
       end
     end

     #Едем на предыдущую станцию
     def previous_station
       if route.starting_station == @station
         puts "this is the first station"
       else
         @station = route.stations[route.stations.index(@station)-1]
       end
     end

     #Возвращаем предыдущую,текущую и следующую станции
     def station_list
          puts "Route movement #{self.route.number}"
        if route.starting_station == @station
          puts "previous station does not exist"
        else
          previous_station = route.stations[route.stations.index(@station)-1]
          puts "Previous station #{previous_station}"
        end
          puts "Current station #{@station}"
        if route.end_station == @station
          puts "next station does not exist"
        else
          next_station = route.stations[route.stations.index(@station)+1]
          puts "Next station #{next_station}"
        end
     end
   end

   class Route

     attr_reader :number, :stations, :starting_station,:end_station

     def initialize(number,starting_station,end_station )
       @number = number
       @stations = [starting_station,end_station]
       @starting_station = starting_station
       @end_station = end_station
     end

     #Добавляем промежуточную станцию
     def add_station(station)
       if @stations.include?(station)
         puts "this station is already on the route"
       else
         @stations.insert(1, station)
         puts "in route #{self.number}  arrived station #{station}"
       end
     end

     #Удаляем станцию
     def del_station(station)
       @stations.delete(station)
         puts "delete station #{station} in route #{self.number}"
     end

     #Список станций в маршруте
     def station_list
       @stations.each do |station|
         puts station
       end
     end
   end

