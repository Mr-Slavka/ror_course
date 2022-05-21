
  require_relative 'carriage'

  class PassengerCarriage < Carriage
    attr_reader :type

    def initialize(number, place)
      super(number, place)
      @type = 'passenger'
    end

    def take_a_place
      raise ' All places are occupied ' if @place <= @remaining_place

      @remaining_place += 1
    end
  end
