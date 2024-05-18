require_relative 'modules/company_name'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'
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

  attr_reader :stations, :trains, :vagons, :routes

  def initialize
    @stations = []
    @trains = []
    @vagons = []
    @routes = []
  end

  MAIN_MENU = [
    'Меню станции',
    'Меню поезда',
    'Меню вагона',
    'Меню маршрута'
  ]

  STATION_MENU = [
    'Создать станцию',
    'Показать список станций',
    'Показать список поездов на станции'
  ]

  TRAIN_MENU = [
    'Создать поезд',
    'Показать список поездов',
    'Назначить маршрут для поезда',
    'Прицепить вагон к поезду',
    'Отцепить вагон от поезда',
    'Переместить поезд по маршруту вперёд',
    'Переместить поезд по маршруту назад',
    'Показать вагоны'
  ]

  VAGON_MENU = [
    'Создать вагон',
    'Показать список вагонов',
    'Купить билет / занять объём'
  ]

  ROUTE_MENU = [
    'Создать маршрут',
    'Показать созданные маршруты',
    'Добавить станцию к маршруту',
    'Удалить станцию из маршрута'
  ]

  def menu
    loop do
      show('Основное меню:', MAIN_MENU)
      case gets.chomp
      when '1' then station_menu
      when '2' then train_menu
      when '3' then vagon_menu
      when '4' then route_menu
      when '0' then exit
      else input_error
      end
    end
  end

  def station_menu
    loop do
      show('Станция:', STATION_MENU)
      case gets.chomp
      when '1' then create_station
      when '2' then stations_list
      when '3' then trains_list_on_station ### stations_with_trains
      when '0' then return
      else input_error
      end
    end
  end

  def train_menu
    loop do
      show('Поезд:', TRAIN_MENU)
      case gets.chomp
      when '1' then create_train
      when '2' then trains_list
      when '3' then assign_route
      when '4' then add_vagon
      when '5' then delete_vagon
      when '6' then go_next_station
      when '7' then go_previous_station
      when '8' then trains_with_vagons
      when '0' then return
      else input_error
      end
    end
  end

  def vagon_menu
    loop do
      show('Вагон:', VAGON_MENU)
      case gets.chomp
      when '1' then create_vagon
      when '2' then vagons_list
      when '3' then reserve
      when '0' then return
      else input_error
      end
    end
  end

  def route_menu
    loop do
      show('Маршрут:', ROUTE_MENU)
      case gets.chomp
      when '1' then create_route
      when '2' then routes_list
      when '3' then add_station
      when '4' then delete_station
      when '0' then return
      else input_error
      end
    end
  end

  protected

  attr_writer :stations, :trains, :vagons, :routes

  def input_error
    puts 'Ошибка ввода'
  end

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
    if stations.none?(@station)
      @stations << Station.new(@station)
      station_created
    end
  end

  def create_train
    train_number_input
    train_type_input
    if train_valid?
      case @train_type
      when 'cargo' then @trains << TrainCargo.new(@train_number, :cargo)
      when 'passenger' then @trains << TrainPassenger.new(@train_number, :passenger)
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
    if choice_train
      train = trains[@choice_train_index]
      vagon_number_input
      if train.class == TrainCargo
        vagons << VagonCargo.new(@vagon_number)
      elsif train.class == TrainPassenger
        vagons << VagonPassenger.new(@vagon_number)
      end
      train.add_vagons(vagons.last)
      vagon_created
    end
  end

  def vagon_created
    puts "Вагон создан. Номер вагона #{vagons.last.number}. Свободно мест: #{vagons.last.available_space}"
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

  def buy_ticket
    puts "Свободно мест: #{vagons[@choice_vagon_index].available_space}"
    vagons[@choice_vagon_index].take_space
  end

  def take_volume
    puts "Доступный объём: #{vagons[@choice_vagon_index].available_space}"
    need_volume_input
    vagons[@choice_vagon_index].take_space(@vol)
  end

  def stations_list
    if check_stations
      stations.each_with_index { |station, index| puts "Индекс #{index}. #{station.name}" }
    else no_stations
    end
  end

  def trains_list
    if check_trains
      trains.each_with_index { |train, index| puts "Индекс #{index}. Номер #{train.number}: #{train.type}. Вагоны: #{train.vagons}. Маршрут: #{train.route.stations}" }
    else no_trains
    end
  end

  def train_info(train)
    puts "Номер #{train.number}. Тип: #{train.type}. Количество вагонов: #{train.vagons.count}"
  end

  def vagon_info(vagon)
    puts "Индекс #{index}. Номер вагона: #{vagon.number}. Тип: #{vagon.type}. Свободно #{vagon.available_space}"
  end

  def vagons_list
    if check_vagons
      vagons.each_with_index { |vagon, index| puts "Индекс #{index}. Номер вагона: #{vagon.number}. Тип: #{vagon.type}." }
    else no_vagons
    end
  end

  def trains_with_vagons
    trains.each do |train|
      train.vagons_detailed { train.vagons_block }
    end
  end

  def trains_list_on_station
    if choice_station
      if check_trains
        station = stations[@choice_station_index]
        trains.each { |train| train_info(train) if train.current_station == (station) }
      else no_trains
      end
    end
  end

  # def stations_with_trains
  #   stations.each do |station|
  #     station.trains_detailed { station.trains_block }
  #   end
  # end

  def routes_list
    if check_routes
      routes.each_with_index { |route, index| puts "Индекс #{index}. #{route.stations}" }
    else no_routes
    end
  end

  def add_station
    if choice_route
      station_name_input
      stations << @station if stations.none?(@station)
      routes[@choice_route_index].add_station(@station)
    end
  end

  def delete_station
    if choice_route
      station_name_input
      routes[@choice_route_index].delete_station(@station)
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
        trains[@choice_train_index].add_vagons(vagons[@choice_vagon_index])
      end
    end
  rescue RuntimeError => e
    puts e.message
  end

  # if trains[@choice_train_index].vagons.none?(@choice_vagon_index)

  def delete_vagon
    if choice_train
      if choice_vagon
        trains[@choice_train_index].delete_vagons(vagons[@choice_vagon_index])
      end
    end
  end

  def go_next_station
    if choice_train
      trains[@choice_train_index].go_next_station
      current_station
    else set_a_route
    end
  end

  def go_previous_station
    if choice_train
      trains[@choice_train_index].go_previous_station
      current_station
    else set_a_route
    end
  end

  def train_valid?
    return Train.new(@train_number, @train_type).valid?
  end

  def vagon_valid?
    return Vagon.new(@vagon_number, @vagon_type).valid?
  end

  def check_stations
    return stations.size > 0
  end

  def check_trains
    return trains.size > 0
  end

  def check_routes
    return routes.size > 0
  end

  def check_vagons
    return vagons.size > 0
  end

  def choice_station
    if check_stations
      select_station_index
      stations.each_with_index { |station, index| puts "#{index}. #{station.name}" }
      @choice_station_index = gets.chomp.to_i
    else no_stations
    end
  end

  def choice_train
    if check_trains
      select_train_index
      trains.each_with_index { |train, index| puts "#{index}. #{train.number}: #{train.type}" }
      @choice_train_index = gets.chomp.to_i
    else no_trains
    end
  end

  def choice_vagon
    if check_vagons
      select_vagon_index
      vagons.each_with_index { |vagon, index| puts "#{index}. #{vagon.number}: #{vagon.type}" }
      @choice_vagon_index = gets.chomp.to_i
    else no_vagons
    end
  end

  def choice_route
    if check_routes
      select_route_index
      routes.each_with_index { |route, index| puts "#{index}. #{route.stations}" }
      @choice_route_index = gets.chomp.to_i
    else no_routes
    end
  end

  def vagon_exists
    puts 'Этот вагон уже прицеплен'
  end

  def current_station
    puts "Текущая станция: #{trains[@choice_train_index].current_station}"
  end

  def train_created
    puts "Поезд создан. Тип поезда: #{@train_type}"
  end

  def station_created
    puts "Станция #{@station} создана"
  end

  def station_name_input
    puts "Введите название станции"
    @station = gets.chomp
  end

  def train_number_input
    puts "Введите номер поезда"
    @train_number = gets.chomp.to_s
  end

  def train_type_input
    puts "Введите passenger, если поезд пассажирский или cargo, если поезд грузовой"
    @train_type = gets.chomp.to_s
  end

  def vagon_number_input
    puts "Введите номер вагона"
    @vagon_number = gets.chomp
  end

  def vagon_type_input
    puts "Введите passenger, если хотите создать пассажирский или cargo, если хотите создать грузовой вагон"
    @vagon_type = gets.chomp.to_s
  end

  def company_name_input
    puts "Введите название компании-производителя"
    @company_name = gets.chomp.to_s
  end

  def first_station_input
    puts "Введите название первой станции"
    @start_station = gets.chomp
  end

  def end_station_input
    puts "Введите название конечной станции"
    @end_station = gets.chomp
  end

  def need_volume_input
    puts 'Введите желаемый объём'
    @vol = gets.chomp.to_i
  end

  def no_stations
    puts "Список станций пуст"
  end

  def no_trains
    puts "Поездов пока нет"
  end

  def no_vagons
    puts "Вагонов пока нет"
  end

  def no_routes
    puts "Маршрутов пока нет"
  end

  def set_a_route
    puts "Установите маршрут"
  end

  def try_again
    puts "Повторите попытку"
  end

  def select_station_index
    puts "Выберите индекс станции"
  end

  def select_train_index
    puts "Выберите индекс поезда"
  end

  def select_vagon_index
    puts "Выберите индекс вагона"
  end

  def select_route_index
    puts "Выберите индекс маршрута"
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
