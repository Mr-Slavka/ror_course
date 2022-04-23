
  class CargoTrain<Train


    attr_reader :type

    def initialize(number)
      super(number)
      @type = "cargo"
    end

    #Цепляем вагоны
    def hitching_wagons(wagon)
      if wagon.class == CargoCarriage
        super(wagon)
      else
        puts "Wrong wagon type"
      end
    end

  end
