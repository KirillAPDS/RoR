require_relative 'modules/company_name'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'
require_relative 'modules/service'
require_relative 'modules/msgs'
require_relative 'trains/train'
require_relative 'trains/train_passenger'
require_relative 'trains/train_cargo'
require_relative 'vagons/vagon'
require_relative 'vagons/vagon_passenger'
require_relative 'vagons/vagon_cargo'
require_relative 'route'
require_relative 'station'

class Main
  include Msgs
  include Service

  attr_reader :stations, :trains, :vagons, :routes

  def initialize
    @stations = []
    @trains = []
    @vagons = []
    @routes = []
  end

  MENU = [
    'Создать станцию',
    'Создать поезд',
    'Создать вагон',
    'Создать маршрут',
    'Показать список станций',
    'Показать список поездов на станциях',
    'Показать список поездов',
    'Показать список вагонов',
    'Показать список вагонов у поездов',
    'Показать список маршрутов',
    'Прицепить вагон к поезду',
    'Отцепить вагон от поезда',
    'Купить билет / занять объём',
    'Добавить станцию к маршруту',
    'Удалить станцию из маршрута',
    'Назначить маршрут для поезда',
    'Переместить поезд по маршруту вперёд',
    'Переместить поезд по маршруту назад'
  ]

  def menu
    loop do
      show('Меню:', MENU)
      case gets.chomp
      when '1' then create_station
      when '2' then create_train
      when '3' then create_vagon
      when '4' then create_route
      when '5' then stations_list
      when '6' then stations_with_trains
      when '7' then trains_list
      when '8' then vagons_list
      when '9' then trains_with_vagons
      when '10' then routes_list
      when '11' then add_vagon
      when '12' then delete_vagon
      when '13' then reserve
      when '14' then add_station
      when '15' then delete_station
      when '16' then assign_route
      when '17' then go_next_station
      when '18' then go_previous_station
      when '0' then exit
      else input_error
      end
    end
  end

  protected

  attr_writer :stations, :trains, :vagons, :routes

  def show(heading, menu)
    puts heading
    show_arr(menu)
    puts '0. Выход'
  end

  def show_arr(arr)
    arr.each.with_index(1) { |item, index| puts "#{index}. #{item}" }
  end

  def create_station
    station_name_input
      @stations << Station.new(@station)
      station_created
  rescue NameError => e
    puts e.message
    try_again
  retry
  end

  def create_train
    train_number_input
    train_type_input
    if train_valid?
      case @train_type
      when 'cargo' then @trains << TrainCargo.new(@train_number)
      when 'passenger' then @trains << TrainPassenger.new(@train_number)
      else try_again
      end
      train_created
    else 
    end
    rescue RuntimeError, TypeError => e
      puts e.message
      try_again
    retry
  end

  def create_vagon
    vagon_number_input
    vagon_type_input
    space_input
    if vagon_valid?
      case @vagon_type
      when 'cargo' then @vagons << VagonCargo.new(@vagon_number, @space)
      when 'passenger' then @vagons << VagonPassenger.new(@vagon_number, @space)
      else try_again
      end
      vagon_created
    else
    end
    rescue RuntimeError, TypeError => e
      puts e.message
      try_again
    retry
  end

  def create_route
    if stations.size < 2
      puts 'No stations for route'
      return
    else
      select_station_index
      stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
      @start_station_index = gets.chomp.to_i
      select_station_index
      stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
      @end_station_index = gets.chomp.to_i
      if @start_station_index == @end_station_index
        puts 'Same stations error'
        return
      else
        route = Route.new(stations[@start_station_index], stations[@end_station_index])
        @routes << route
        puts "Маршрут создан. Станции: #{route.stations.first.name} - #{route.stations.last.name}"
      end
    end
  end

  def reserve
    if choice_vagon
      case vagons[@choice_vagon_index]
      when VagonPassenger then buy_ticket
      when VagonCargo then take_volume
      end
    end
  end

  def trains_with_vagons
    trains.each do |train|
      train.vagons_detailed { train.vagons_block }
    end
  end

  def stations_with_trains
    stations.each do |station|
      station.trains_detailed { station.trains_block }
    end
  end

  def add_station
    if choice_route
      station_name_input
      stations << Station.new(@station) if stations.none?(@station)
      route = routes[@choice_route_index]
      route.add_station(@station)
    end
  end

  def delete_station
    if choice_route
      station_name_input
      route = routes[@choice_route_index]
      route.delete_station(@station)
    end
  end

  def assign_route
    if choice_train
      if choice_route
        train = trains[@choice_train_index]
        route = routes[@choice_route_index]
        train.route=route
        current_station
        station = train.current_station
        station.add_train(train)
      end
    end
  end

  def add_vagon
    if choice_train
      if choice_vagon
        train = trains[@choice_train_index]
        vagon = vagons[@choice_vagon_index]
        train.add_vagons(vagon)
      end
    end
  rescue RuntimeError => e
    puts e.message
  end

  def delete_vagon
    if choice_train
      if choice_vagon
        train = trains[@choice_train_index]
        vagon = vagons[@choice_vagon_index]
        train.delete_vagons(vagon)
      end
    end
  rescue RuntimeError => e
    puts e.message
  end

  def go_next_station
    if choice_train
      train = trains[@choice_train_index]
      train.current_station.send_train(train)
      train.go_next_station
      train.current_station.add_train(train)
      current_station
    else set_a_route
    end
  end

  def go_previous_station
    if choice_train
      train = trains[@choice_train_index]
      train.current_station.send_train(train)
      train.go_previous_station
      train.current_station.add_train(train)
      current_station
    else set_a_route
    end
  end
end

# Main.new.menu











  # def trains_on_station
  #   if choice_station
  #     station = stations[@choice_station_index]
  #     station.trains_detailed { station.trains_block }
  #   end
  # end

  # def vagons_list_by_train
  #   if check_vagons
  #     vagons.each_with_index { |vagon, index| puts "Индекс #{index}. #{vagon}: #{vagon.type}" }
  #   else no_vagons
  #   end
  # end

  # station.trains_detailed { station.trains_block } if station == train.current_station #if station.trains.current_station.eql?(station)

  # def trains_list_on_station
  #   if choice_station
  #     if check_trains
  #       trains.each { |train| puts "Номер #{train.number}: #{train.type}" if train.current_station.eql?(stations[@choice_station_index]) }
  #     else no_trains
  #     end
  #   end
  # end

  # def train_info(train)
  #   puts "Номер #{train.number}. Тип: #{train.type}. Количество вагонов: #{train.vagons.count}"
  # end

  # def vagon_info(vagon)
  #   puts "Индекс #{index}. Номер вагона: #{vagon.number}. Тип: #{vagon.type}. Свободно #{vagon.available_space}"
  # end

  # if trains[@choice_train_index].vagons.none?(@choice_vagon_index)

  # def create_vagon
  #   if choice_train
  #     train = trains[@choice_train_index]
  #     vagon_number_input
  #     if train.class == TrainCargo
  #       vagons << VagonCargo.new(@vagon_number)
  #     elsif train.class == TrainPassenger
  #       vagons << VagonPassenger.new(@vagon_number)
  #     end
  #     train.add_vagons(vagons.last)
  #     vagon_created
  #   end
  # rescue RuntimeError, TypeError => e
  #   puts e.message
  #   try_again
  # retry
  # end
