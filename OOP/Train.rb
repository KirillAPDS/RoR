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

  attr_accessor :station
  attr_accessor :speed
  attr_accessor :count_of_vans
  attr_accessor :route

  attr_reader :number
  attr_reader :type
  
# начальные значения  
  def initialize(number, type, count_of_vans)
    @number = number
    @type = type
    @count_of_vans = count_of_vans
    @speed = 0
  end

# набор скорости
  def gain_speed(speed)
    self.speed = speed
  end

# возвращение текущей скорости
  def speed
    self.speed = @speed
  end

# сброс скорости до нуля
  def stop
    self.speed = 0
  end

# возвращение количества вагонов
  def count_of_vans
    self.count_of_vans = @count_of_vans
  end

# прицепка вагона
  def add_van
    if @speed == 0
      self.count_of_vans += 1
    else
      puts "Сначала остановите поезд"
    end
  end

# отцепка вагона
  def delete_van
    if @speed == 0
      self.count_of_vans -= 1
    else
      puts "Сначала остановите поезд"
    end
  end

# прием маршрута следования
  def route=(route)
    @route = route
    self.station = self.route.stations.first
  end

# перемещение на одну станцию вперёд
  def move_next_station
    self.station = self.route.stations[self.route.stations.index(self.station) + 1]
  end

# перемещение на одну станцию назад
  def move_back_station
    self.station = self.route.stations[self.route.stations.index(self.station) - 1]
  end

# предыдущая станция
  def previous_station
    self.route.stations[self.route.stations.index(self.station) - 1]
  end

# текущая станция
  def current_station
    self.route.stations[self.route.stations.index(self.station)]
  end

# следующая станция
  def next_station
    self.route.stations[self.route.stations.index(self.station) + 1]
  end

end