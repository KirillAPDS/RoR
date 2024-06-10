# frozen_string_literal: true

module Service
  def train_valid?
    Train.new(@train_number, @train_type).valid?
  end

  def vagon_valid?
    Vagon.new(@vagon_number, @space, @vagon_type).valid?
  end

  def trains_with_vagons
    trains.each(&:vagons_block)
  end

  def stations_with_trains
    stations.each(&:trains_block)
  end

  def create_vagon_input
    vagon_number_input
    space_input
    vagon_type_input
  end

  def choice_item(items)
    return unless items_list(items)

    select_item_index
    @item_index = gets.chomp.to_i
  end

  def items_valid?(items)
    raise "No items" if items.empty?
  end

  def items_list(items)
    items_valid?(items)
    items.each_with_index { |item, index| puts "#{index}. #{item.info}" }
  rescue RuntimeError => e
    puts e.message
    try_again
  end

  def stations_list
    raise "No stations" if stations.empty?
    items_list(stations)
  rescue RuntimeError => e
    puts e.message
  end

  def trains_list
    raise "No trains" if trains.empty?
    items_list(trains)
  rescue RuntimeError => e
    puts e.message
  end

  def show_menu(heading, menu)
    puts heading
    menu.each.with_index(1) { |item, index| puts "#{index}. #{item}" }
    puts '0. Выход'
  end

  def buy_ticket(vagon)
    vagon.take_space
  end

  def take_volume(vagon)
    need_volume_input
    vagon.take_space(@vol)
  end

  def space_input
    puts 'Введите количество мест / объём'
    @space = gets.chomp.to_i
  end

  def input_error
    puts 'Ошибка ввода'
  end

  def vagon_exists
    puts 'Этот вагон уже прицеплен'
  end

  def vagon_created
    puts "Вагон создан. Номер: #{vagons.last.number}. Свободно мест: #{vagons.last.available_space}"
  end

  def current_station
    puts "Текущая станция: #{trains[@item_index].current_station}"
  end

  def train_created
    puts "Поезд создан. Тип поезда: #{@train_type}"
  end

  def station_created
    puts "Станция #{@station} создана"
  end

  def station_name_input
    puts 'Введите название станции'
    @station = gets.chomp
  end

  def train_number_input
    puts 'Введите номер поезда'
    @train_number = gets.chomp.to_s
  end

  def train_type_input
    puts 'Введите passenger, если поезд пассажирский или cargo, если поезд грузовой'
    @train_type = gets.chomp.to_s
  end

  def vagon_number_input
    puts 'Введите номер вагона'
    @vagon_number = gets.chomp
  end

  def vagon_type_input
    puts 'Введите passenger, если хотите создать пассажирский или cargo, если хотите создать грузовой вагон'
    @vagon_type = gets.chomp.to_s
  end

  def company_name_input
    puts 'Введите название компании-производителя'
    @company_name = gets.chomp.to_s
  end

  def first_station_input
    puts 'Введите название первой станции'
    @start_station = gets.chomp
  end

  def end_station_input
    puts 'Введите название конечной станции'
    @end_station = gets.chomp
  end

  def need_volume_input
    puts 'Введите желаемый объём'
    @vol = gets.chomp.to_i
  end

  def not_enough_stations
    puts 'Недостаточно станций'
  end

  def set_a_route
    puts 'Установите маршрут'
  end

  def try_again
    puts 'Повторите попытку'
  end

  def select_item_index
    puts 'Выберите индекс'
  end
end
