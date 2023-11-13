=begin
  
Класс Route (Маршрут):
• Имеет начальную и конечную станцию, а также список промежуточных станций. 
  Начальная и конечная станции указываютсся при создании маршрута, 
  а промежуточные могут добавляться между ними.
• Может добавлять промежуточную станцию в список
• Может удалять промежуточную станцию из списка
• Может выводить список всех станций по-порядку от начальной до конечной

=end

class Route

  # attr_reader :stations

  def initialize(start_station, destination)
    @stations = []
    @stations << start_station
    @stations << destination
  end

# добавление станции на передпоследнее место в списке (индекс равен -2)
  def add_station(station)
    stations.insert(-2, station)
  end

# удаление станции
  def delete_station(station)
    stations.delete(station)
  end

# вывод списка всех станций
  def stations_list
    puts "Список станций от начальной до конечной: "
    puts stations
  end

end