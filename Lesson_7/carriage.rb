
  require_relative 'manufacturer'

  class Carriage

    include Manufacturer

    attr_reader :number, :place
    attr_accessor :remaining_place

    def initialize(number,place)
      @number = number
      @place = place
      @remaining_place = 0
    end


    def take_a_place(place)
      raise " Place busy or insufficient"  if @place < @remaining_place || @place < @remaining_place + place
      @remaining_place += place
    end

    def  occupied_place
      @remaining_place
    end

    def  free_place
      @place - @remaining_place
    end
  end