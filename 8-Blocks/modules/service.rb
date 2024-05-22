module Service

  def train_valid?
    return Train.new(@train_number, @train_type).valid?
  end

  def vagon_valid?
    return Vagon.new(@vagon_number, @vagon_type, @space).valid?
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

    def stations_list
    if check_stations
      stations.each_with_index { |station, index| puts "Индекс #{index}. #{station.name}" }
    else no_stations
    end
  end

  def trains_list
    if check_trains
      trains.each_with_index { |train, index| puts "Индекс #{index}. Номер #{train.number}: #{train.type}. Вагоны: #{train.vagons}. Маршрут: #{train.route}" }
    else no_trains
    end
  end

  def vagons_list
    if check_vagons
      vagons.each_with_index { |vagon, index| puts "Индекс #{index}. Номер вагона: #{vagon.number}. Тип: #{vagon.type}." }
    else no_vagons
    end
  end

  def routes_list
    if check_routes
      routes.each_with_index { |route, index| puts "Индекс #{index}. #{route.stations}" }
    else no_routes
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

  def space_input
    puts "Введите количество мест / объём"
    @space = gets.chomp.to_i
  end

  def input_error
    puts 'Ошибка ввода'
  end

  def vagon_exists
    puts 'Этот вагон уже прицеплен'
  end

  def vagon_created
    puts "Вагон создан. Номер вагона #{vagons.last.number}. Свободно мест: #{vagons.last.available_space}"
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