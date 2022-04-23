
  require_relative 'carriage.rb'

  class CargoCarriage<Carriage

    attr_reader :volume,:number,:type
    attr_accessor :remaining_volume

    def initialize(number,volume)
      @number = number
      @volume = volume
      @remaining_volume = 0
      @type = "cargo"
    end

    def take_a_volume(volume)
      raise " Volume busy or insufficient"  if @volume < @remaining_volume || @volume < @remaining_volume + volume
      @remaining_volume += volume
    end

    def  occupied_volume
      @remaining_volume
    end

    def  free_volume
      @volume - @remaining_volume
    end

  end