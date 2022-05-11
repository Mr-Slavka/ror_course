
  class PassengerTrain < Train
    attr_reader :type

    def initialize(number)
      super(number)
      @type = 'passenger'
    end

    # Цепляем вагоны
    def hitching_wagons(wagon)
      if wagon.instance_of?(PassengerCarriage)
        super(wagon)
      else
        puts 'Wrong wagon type'
      end
    end
  end
