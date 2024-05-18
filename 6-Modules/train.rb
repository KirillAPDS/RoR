require_relative 'modules/company_name.rb'
require_relative 'modules/instance_counter.rb'

class Train
  include CompanyName
  include InstanceCounter

  attr_accessor :speed
  attr_reader :route, :number, :type, :vagons
  
  def initialize(number, type)
    @number = number
    @type = type
    @vagons = []
    @speed = 0
    @route = nil
    register_instance
  end

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def add_vagons(vagon)
    @vagons << vagon if @speed == 0 && vagon.type == type
  end

  def delete_vagons(vagon)
    @vagons.delete(vagon) if @speed == 0
  end

  def route=(route)
    @route = route
    @current_station_index = 0
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end

  def go_next_station
    if route != nil
      @current_station_index += 1
      @current_station = route.stations[@current_station_index]
    else lets_set_route
    end
  end

  def go_previous_station
    if route != nil
      @current_station_index -= 1
      @current_station = route.stations[@current_station_index]
    else lets_set_route
    end
  end

  def current_station
    if @route == nil
      @current_station = nil
    else @current_station = @route.stations[@current_station_index]
    end
  end

  def lets_set_route
    puts "Установите маршрут"
  end
end

  






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
  # def stop
  #   @speed = 0
  # end

