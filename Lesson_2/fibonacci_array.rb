  #  Заполнить массив числами фибоначчи до 100
  fibonacci_array = [0,1]
  loop do value = fibonacci_array[-1] + fibonacci_array[-2]
     break if value > 100
     fibonacci_array << value
  end
  puts fibonacci_array
