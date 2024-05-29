# frozen_string_literal: true

class Train
  include CompanyName
  include InstanceCounter
  include Validation
  include Msgs

  attr_accessor :speed, :number, :type
  attr_reader :route, :vagons

  @@trains = []

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @vagons = []
    @speed = 0
    @route = nil
    @@trains << self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def add_vagons(vagon)
    add_vagons_validate!(vagon)
    @vagons << vagon if @speed.zero? && vagon.type == type
  end

  def delete_vagons(vagon)
    @vagons.delete(vagon) if @speed.zero?
  end

  def route=(route)
    @route = route
    @current_station_index = 0
    current_station
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end

  def go_next_station
    if !route.nil?
      @current_station_index += 1
      @current_station = route.stations[@current_station_index]
    else
      lets_set_route
    end
  end

  def go_previous_station
    if !route.nil?
      @current_station_index -= 1
      @current_station = route.stations[@current_station_index]
    else
      lets_set_route
    end
  end

  def current_station
    @current_station = if @route.nil?
                         nil
                       else
                         @route.stations[@current_station_index]
                       end
  end

  def vagons_detailed(&block)
    block.call
  end

  def vagons_block
    puts "Номер поезда: #{number}"
    puts 'Вагоны:'
    @vagons.each do |vagon|
      puts "Номер: #{vagon.number}. Тип: #{vagon.type}. Свободно: #{vagon.available_space}. Занято: #{vagon.reserved}."
    end
    puts
  end

  def info
    "Номер: #{number}. Тип: #{type}. Количество вагонов: #{vagons.size}"
  end

  protected

  def validate!
    raise NUMBER_ERROR.to_s if number !~ TRAIN_NUMBER_FORMAT
    raise TypeError, TYPE_ERROR if type !~ TYPES
  end

  def add_vagons_validate!(vagon)
    raise ITEM_ALREADY_EXISTS.to_s if vagons.include?(vagon)
  end

  def lets_set_route
    puts 'Установите маршрут'
  end
end
