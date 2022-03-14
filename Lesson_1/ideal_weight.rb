
  puts "Привет! Как тебя зовут ?"
  name = gets.chomp
  name.capitalize!
  puts "#{name} какой у тебя рост ?"
  growth = gets.chomp
  idea_weight = (growth.to_i - 110)*1.15
  if idea_weight<0
    puts "#{name} твой вес уже оптимальный"
  else
    puts "#{name} твой идеальный вес #{idea_weight}"
  end