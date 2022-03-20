
  vowels_hash = {}
  vowels = %w(a e i o u)
  letters = ("a".."z")
  num = 0

  letters.each do |letter|
    num += 1
    vowels_hash[letter.to_sym] = num if vowels.include?(letter)
  end

  puts vowels_hash