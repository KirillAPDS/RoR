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

  attr_accessor :station, :speed, :count_of_vans
  attr_reader :route, :number, :type
  
# начальные значения  
  def initialize(number, type, vans)
    @number = number
    @type = type
    @vans = vans
    @speed = 0
  end

  def type
    return @type
  end

# набор скорости
  def gain_speed(speed)
    self.speed += speed
  end

# возвращение текущей скорости
  def speed
    return @speed
    # self.speed = @speed
  end

# сброс скорости до нуля
  def stop
    self.speed = 0
  end

# возвращение количества вагонов
  def vans
    return @vans
  end

# прицепка вагона
  def add_van
    if self.speed == 0
      @vans += 1
    else
      puts "Сначала остановите поезд"
    end
  end

# отцепка вагона
  def delete_van
    if self.speed == 0
      @vans -= 1
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