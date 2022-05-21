
  require_relative 'Modules/validation'

  class CargoTrain < Train

    include Validation

    attr_reader :type


    REGEXP = /[a-zа-я\d]{3}-?[a-zа-я\d]{2}/i

    validate :number, :presence
    validate :number, :length, 5
    validate :number, :format, REGEXP
    validate :number, :validation_type, String

    def initialize(number)
      super(number)
      @type = 'cargo'
      validate!
    end

    # Цепляем вагоны
    def hitching_wagons(wagon)
      if wagon.instance_of?(CargoCarriage)
        super(wagon)
      else
        puts 'Wrong wagon type'
      end
    end
  end
