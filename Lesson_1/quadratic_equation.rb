
  puts "Квадратное уравнение"
  puts "введите коеффициент а"
  a = gets.chomp.to_i
  puts "введите коеффициент b"
  b = gets.chomp.to_i
  puts "введите коеффициент c"
  c = gets.chomp.to_i

  discriminant = b**2 - (4*a*c)

  if  discriminant < 0
    puts "Дискриминант равен #{discriminant}. Корней нет"
  elsif discriminant == 0
    x = -b/2*a
    puts "Дискриминант равен #{discriminant}. Один корень #{x} "
  else
    x1 = -b + Math.sqrt(discriminant) / 2 * a
    x2 = -b - Math.sqrt(discriminant) / 2 * a
    puts "Дискриминант равен #{discriminant}. Два корня #{x1},#{x2}"
  end