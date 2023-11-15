=begin
  
Класс Train (Поезд):
• Имеет номер (произвольная строка) и тип (грузовой, пассажирский) 
  и количество вагонов, эти данные указываются при создании экземпляра класса
• Может набирать скорость
• Может возвращать текущую скорость
• Может тормозить (сбрасывать скорость до нуля)
• Может возвращать количество вагонов
• Может прицеплять/отцеплять вагоны (по одному вагону за операцию, 
  метод просто увеличивает или уменьшает количество вагонов). 
  Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
• Может принимать маршрут следования (объект класса Route). 
• При назначении маршрута поезду, поезд автоматически 
  помещается на первую станцию в маршруте.
• Может перемещаться между станциями, указанными в маршруте. 
  Перемещение возможно вперед и назад, но только на 1 станцию за раз.
• Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

=end

class Train
  attr_accessor :speed
  attr_reader :route, :number, :type, :vagons
  
  def initialize(number, type, vagons)
    @number = number
    @type = type
    @vagons = vagons
    @speed = 0
  end

# прицепка вагона
  def add_vagons
    @vagons += 1 if @speed == 0
  end

# отцепка вагона
  def delete_vagons
    @vagons -= 1 if @speed == 0
  end

# прием маршрута следования
  def route=(route)
    @route = route
    @current_station_index = 0
  end

  def current_station
    route.stations[@current_station_index]
  end

# следующая станция
  def next_station
    route.stations[@current_station_index + 1]
  end

# предыдущая станция
  def previous_station
    route.stations[@current_station_index - 1]
  end

# перемещение на одну станцию вперёд
  def go_next_station
    @current_station_index += 1
    @current_station = route.stations[@current_station_index]
  end

# перемещение на одну станцию назад
  def go_previous_station
    @current_station_index -= 1
    @current_station = route.stations[@current_station_index]
  end
end


=begin

# возвращение количества вагонов
  # def vagons
  #   @vagons
  # end
  
# возвращение текущей скорости
  # def speed
  #   return @speed
  #   # self.speed = @speed
  # end

  # def type
  #   return @type
  # end

  # else
    #   puts "Сначала остановите поезд"
    # end

  # текущая станция
  # def current_station
  #   route.stations[route.stations.index(station)]
  # end

  # набор скорости
  # def gain_speed(speed)
  #   @speed += speed
  # end

  # сброс скорости до нуля
  def stop
    @speed = 0
  end

=end