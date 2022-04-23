
  require_relative 'carriage.rb'

  class PassengerCarriage < Carriage


    attr_reader :places,:number,:type
    attr_accessor :remaining_places

    def initialize(number,places)
      @number = number
      @places = places
      @remaining_places = 0
      @type = "passenger"
    end

    def take_the_place
      raise " All places are occupied "  if @places <= @remaining_places
      @remaining_places += 1
    end

    def  occupied_places
      @remaining_places
    end

    def  vacancies
      @places - @remaining_places
    end

  end
