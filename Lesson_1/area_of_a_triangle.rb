
  puts "Вычисляем площадь треугольника"
  puts "Введите длинну основания треугольника"
  base_length = gets.chomp
  puts "Введите высоту треугольника"
  h = gets.chomp
  area_of_a_triangle= (0.5 * base_length.to_i) * h.to_i
  puts "Площадь треугольника равна #{area_of_a_triangle}"