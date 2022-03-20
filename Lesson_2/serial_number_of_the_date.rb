  puts "Введите число"
  date = gets.chomp.to_i
  puts "Введите месяц"
  month = gets.chomp.to_i
  puts "Введите год"
  year = gets.chomp.to_i
  month_days = { "1" => 31,
                 "2" => 28,
                 "3" => 31,
                 "4" => 30,
                 "5" => 31,
                 "6" => 30,
                 "7" => 31,
                 "8" => 31,
                 "9" => 30,
                 "10" => 31,
                 "11" => 30,
                 "12" => 31
  }

  #проверка на високосный год
  if (year % 100 == 0 && year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
    leap_year = true
  else
    leap_year = false
  end
  month_days["2"] = 29 if leap_year

  serial_number=0
  month_days.each do |month_number, month_days|
    if month_number.to_i == month
      serial_number += date
    elsif month_number.to_i < month
      serial_number += month_days
    end
  end

  puts "Порядковый номер даты #{serial_number}"