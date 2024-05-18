puts "Введите ваше имя: "
user_name = gets.chomp

puts "Введите ваш рост в сантиметрах: "
height = gets.chomp

ideal_weight = (height.to_i - 110) * 1.15

if ideal_weight < 0
	puts "Ваш вес уже оптимальный"
else
	puts "#{user_name.capitalize}, Ваш идеальный вес равен #{ideal_weight} кг."
end