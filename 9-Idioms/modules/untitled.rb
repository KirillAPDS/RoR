# frozen_string_literal: true

# 1 Даны списки

arr1 = []
arr2 = []
arr3 = []
arr4 = []

# Выводим элементы списка

def items_list(items)
  if items.size.positive?
    items.each_with_index { |item, index| puts "#{index}. #{item}" }
  else
    puts 'No [items] items'
  end
end

# Код ниже выдаст всегда одно, а хотелось бы именное сообщение
# В [items] - имя списка

items_list(arr1)
items_list(arr2)
items_list(arr3)
items_list(arr4)

# Иначе при обращении к тому или иному списку приходится для каждого писать свой вывод

# Ну оберните в какой-то объект с атрибутом name или для чего всё это? Кроме исследования возможностей языка ещё есть какая-то мотивация?

# Ну или самое простое { name: :azaza, objects: [] }
