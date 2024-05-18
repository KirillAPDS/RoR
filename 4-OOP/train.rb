class Train
  attr_accessor :speed
  attr_reader :route, :number, :type, :vagons
  
  def initialize(number, type, vagons)
    @number = number
    @type = type
    @vagons = vagons
    @speed = 0
  end

  def add_vagons
    @vagons += 1 if @speed == 0
  end

  def delete_vagons
    @vagons -= 1 if @speed == 0
  end

  def route=(route)
    @route = route
    @current_station_index = 0
  end

  def current_station
    route.stations[@current_station_index]
  end

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    route.stations[@current_station_index - 1]
  end

  def go_next_station
    @current_station_index += 1
    @current_station = route.stations[@current_station_index]
  end

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