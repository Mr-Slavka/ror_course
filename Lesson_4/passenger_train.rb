
class PassengerTrain<Train

  #Цепляем вагоны
  def hitching_wagons(wagon)
    if wagon.class == PassengerCarriage
      super(wagon)
    else
      puts "Wrong wagon type"
    end
  end

end