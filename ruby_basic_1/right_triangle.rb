puts "Введите длину первой стороны треугольника"
side_1 = gets.chomp.to_i

puts "Введите длину второй стороны треугольника"
side_2 = gets.chomp.to_i

puts "Введите длину третьей стороны треугольника"
side_3 = gets.chomp.to_i

if side_1 == side_2 && side_2 == side_3
	puts "Этот треугольник равносторонний"
elsif side_1 == side_2 || side_1 == side_3 || side_2 == side_3
	puts "Этот треугольник равнобедренный"
elsif side_1 > side_2 && side_1 > side_3
	check = side_1 ** 2 == side_2 ** 2 + side_3 ** 2
	if check
		puts "Этот треугольник является прямоугольным"
	else
		puts "Этот треугольник не является равносторонним, равнобедренным или прямоугольным"
	end
elsif side_2 > side_1 && side_2 > side_3
	check = side_2 ** 2 == side_1 ** 2 + side_3 ** 2
	if check
		puts "Этот треугольник является прямоугольным"
	else
		puts "Этот треугольник не является равносторонним, равнобедренным или прямоугольным"
	end
elsif side_3 > side_1 && side_3 > side_2
	check = side_3 ** 2 == side_1 ** 2 + side_2 ** 2
	if check
		puts "Этот треугольник является прямоугольным"
	else
		puts "Этот треугольник не является равносторонним, равнобедренным или прямоугольным"
	end
end