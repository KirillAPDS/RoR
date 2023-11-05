=begin

5. Заданы три числа, которые обозначают число, месяц, год 
(запрашиваем у пользователя). 
Найти порядковый номер даты, начиная отсчет с начала года. 
Учесть, что год может быть високосным. 
(Запрещено использовать встроенные в ruby методы для этого 
вроде Date#yday или Date#leap?) 
Алгоритм опредления високосного года: docs.microsoft.com

=end

# запрашиваем число, месяц, год
puts "Введите число: "
date = gets.chomp.to_i

puts "Введите номер месяца: "
month = gets.chomp.to_i

puts "Введите год: "
year = gets.chomp.to_i

# если год високосный, то количество дней в нём равно 366
# иначе количество дней в нём равно 365 (год не високосный)
  if year % 4 == 0 && year % 100 == 0 && year % 400 == 0
	  days_per_year = 366
  else
	  days_per_year = 365
  end

# задаём массив количества дней в месяцах
days_per_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# начинаем считать порядковый номер даты
date_sequence_number = date

# задаем цикл для подсчета количества дней по предыдущим месяцам
# и прибавляем их к порядковому номеру даты
  for i in 0..(month - 2)
		date_sequence_number += days_per_months[i]
  end

# далее учитываем високосность года
	if days_per_year == 366 && month >= 3
    date_sequence_number += 1
  end

puts date_sequence_number






# if month >= 3
# 	if days_per_year == 366
# 		for i in 0..(month - 2)
# 			result += days_per_months[i]
# 		end
# 	elsif days_per_year == 365
# 		for i in 0..(month - 2)
# 			result += days_per_months[i]
# 		end
# 	end
# else
# 	for i in 0..(month - 2)
# 		result += days_per_months[i]
# 	end
# end
