=begin

4. Заполнить хеш гласными буквами, 
где значением будет являтся 
порядковый номер буквы в алфавите (a - 1).

=end

# Задаём массивы: латинского алфавита alph
# и его гласных букв vowels
# а также инициализируем результирующий хэш vowels_hash
alph = ('a'..'z').to_a
vowels = ["a", "e", "i", "o", "u"]
vowels_hash = Hash.new

# в цикле проходимся по массиву vowels
# и добавляем в vowels_hash гласную букву как ключ 
# и ее номер в алфавите как значение
# прибавляем 1, т.к. индексация массивов начинается с 0
  for vowel in vowels
    vowels_hash[vowel] = alph.index(vowel) + 1
  end

puts vowels_hash

# Ниже оставил комменты для себя

# for vowel in vowels
# 	puts vowel
# 	puts alph.index(vowel) + 1
# end
