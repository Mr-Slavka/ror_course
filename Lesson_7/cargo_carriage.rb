
  require_relative 'carriage.rb'

  class CargoCarriage<Carriage

    attr_reader :type

    def initialize(number,place)
      super(number,place)
      @type = "cargo"
    end
  end