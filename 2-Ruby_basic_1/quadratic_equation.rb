include Math

puts "Введите коэффициент a "
coeff_a = gets.chomp.to_i

puts "Введите коэффициент b "
coeff_b = gets.chomp.to_i

puts "Введите коэффициент c "
coeff_c = gets.chomp.to_i

discriminant = coeff_b ** 2 - 4 * coeff_a * coeff_c


if discriminant < 0
	puts "Дискриминант равен #{discriminant}"
	puts "Корней нет"
elsif discriminant == 0
	sqrt_1 = (Math.sqrt(discriminant) - coeff_b) / (2 * coeff_a)
	puts "Дискриминант равен #{discriminant}"
	puts "Корень равен #{sqrt_1}"
else
	sqrt_1 = (Math.sqrt(discriminant) - coeff_b) / (2 * coeff_a)
	sqrt_2 = (-Math.sqrt(discriminant) - coeff_b) / (2 * coeff_a)
	puts "Дискриминант равен #{discriminant}"
	puts "Корень 1 равен #{sqrt_1}"
	puts "Корень 2 равен #{sqrt_2}"
end
