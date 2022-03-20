
  cart = Hash.new
  loop do
    puts "Введите название товара или 'стоп' для завершения "
    title = gets.chomp.downcase
    break if title == 'стоп'
    puts "Введите цену товара"
    price = gets.chomp.to_f
    puts "Введите количество товара"
    quantity = gets.chomp.to_f

    cart[title] = {price => quantity}
    end
    total_price = 0
    cart.each do |title, price|
      puts "#{title.capitalize}: #{price.keys.first} * #{price.values.first} Общая стоимость-#{price.keys.first * price.values.first}"
      total_price += price.keys.first * price.values.first
    end
    puts "Стоимость всех товаров в корзине: #{total_price}"
