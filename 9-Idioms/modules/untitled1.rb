arr1 = [*'a'..'f']
arr2 = [*10..15]
arr3 = %w[z y x]
arr4 = []

puts(
  { arr1:, arr2:, arr3:, arr4: }.map do |items_name, items|
      next "No items in #{items_name}" if items.empty?
      items
        .map.with_index(1) { |item, index| "#{index}. #{item}" }
        .join("\n")
  end
  .join("\n" * 2)
)


arr1 = [*'a'..'f']
arr2 = [*10..15]
arr3 = %w[z y x]
arr4 = []

def items_list(items, items_name)
  return "No items in #{items_name}" if items.empty?
  items.map.with_index(1) { |item, index| "#{index}. #{item}" }.join("\n")
end

puts ('arr1'..'arr4').map { |variable_name| items_list(eval(variable_name), variable_name) }.join("\n" * 2)

```
=begin Валерий, привет! Спасибо! Но я видимо неправильно сформулировал. 
       
1. В задании я обращаюсь к конкретному списку
через items_list(items) для вывода его элементов 
или сообщения, что он пуст, например: 
=end

  def items_list(items, items_name)
    return "No #{items_name}" if items.empty?
    items.map.with_index(1) { |item, index| puts "#{index}. #{item}" }
  end

  stations = []

  items_list(stations, 'stations')

=begin 

Все работает

2. Также к списку обращаюсь через
choice_item(items), где выбираю элемент для 
дальнейших действий с ним.
Если ввести имя переменной вторым аргументом,
то его придется прописать всюду, где идет обращение
через choice_item(items). Так можно сделать,
но выглядит некрасиво. Если бы речь шла только
о выводе элементов списка через items_list(items), 
то да, вариант огонь.
=end

  def choice_item(items)
    return unless items_list(items)

    select_item_index
    @item_index = gets.chomp.to_i
  end
```

stations_list = items_list(stations, 'stations')
trains_list = items_list(trains, 'trains')
vagons_list = items_list(vagons, 'vagons')
routes_list = items_list(routes, 'routes')
