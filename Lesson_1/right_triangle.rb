
  puts "Прямоугольный треугольник"
  puts "введите сторону а"
  a = gets.chomp.to_f
  puts "введите сторону b"
  b = gets.chomp.to_f
  puts "введите сторону c"
  c = gets.chomp.to_f
  # проверка прямоугольный ли треугольник
  # без метода .round проверка не проходит из за погрешности в расчетах
  if (a**2).round == (b**2).round + (c**2).round ||
     (b**2).round == (a**2).round + (c**2).round ||
     (c**2).round == (a**2).round + (b**2).round
    right_triangle=true
  else
    right_triangle=false

  end

  #какой треугольник
  if right_triangle
    puts " Tреугольник прямоугольный"
  elsif a == b && a == c && b == c
    puts " Tреугольник равносторонний"
  elsif a == b || a == c || b == c
    puts " Tреугольник равнобедренный"
  else
    puts "Tреугольник ни прямоугольный, ни равнобедренный, ни равносторонний"
  end
