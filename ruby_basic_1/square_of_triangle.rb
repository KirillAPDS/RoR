puts "Чему равно основание треугольника в сантиметрах? "
footing = gets.chomp

puts "Чему равна высота треугольника в сантиметрах?"
height = gets.chomp

square_of_triangle = footing.to_i * height.to_i * 0.5


puts "Площадь этого треугольника равна #{square_of_triangle} квадратных сантиметров."