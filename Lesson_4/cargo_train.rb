
  class CargoTrain<Train

    #Цепляем вагоны
    def hitching_wagons(wagon)
      if wagon.class == CargoCarriage
        super(wagon)
      else
        puts "Wrong wagon type"
      end
    end

  end
