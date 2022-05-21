
  require_relative 'Modules/validation'

  class PassengerTrain < Train
    attr_reader :type

    include Validation

    REGEXP = /[a-zа-я\d]{3}-?[a-zа-я\d]{2}/i

    validate :number, :presence
    validate :number, :length, 5
    validate :number, :format, REGEXP
    validate :number, :validation_type, String


    def initialize(number)
      super(number)
      @type = 'passenger'
      validate!
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
