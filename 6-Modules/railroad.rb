class RailRoad
  attr_reader :stations, :trains, :vagons, :routes

  def initialize
    @stations = []
    @trains = []
    @vagons = []
    @routes = []
  end

  MAIN_MENU = [
    "Введите 1, если хотите создать станцию, поезд, вагон или маршрут",
    "Введите 2, если хотите получить информацию об объектах",
    "Введите 3, если хотите произвести операции с созданными объектами",
    "Введите 0, если хотите закончить программу"
  ]

  CREATE_MENU = [
    "Введите 1, если хотите создать станцию",
    "Введите 2, если хотите создать поезд",
    "Введите 3, если хотите создать вагон",
    "Введите 4, если хотите создать маршрут",
    "Введите 0, если хотите закончить программу"
  ]

  INFO_MENU = [
    "Введите 1, если хотите посмотреть список станций",
    "Введите 2, если хотите посмотреть список поездов",
    "Введите 3, если хотите посмотреть список поездов на станции",
    "Введите 4, если хотите посмотреть список вагонов",
    "Введите 5, если хотите посмотреть список маршрутов",
    "Введите 0, если хотите закончить программу"
  ]

  OPERATION_MENU = [
    "Введите 1, если хотите произвести операции с маршрутом",
    "Введите 2, если хотите произвести операции с поездом",
    "Введите 0, если хотите закончить программу"
  ]

  ROUTE_MENU = [
    "Введите 1, если хотите добавить станцию к маршруту",
    "Введите 2, если хотите удалить станцию у маршрута",
    "Введите 0, если хотите закончить программу"
  ]

  TRAIN_MENU = [
    "Введите 1, Если хотите назначить маршрут для поезда",
    "Введите 2, если хотите добавить вагон к поезду",
    "Введите 3, если хотите отцепить вагон от поезда",
    "Введите 4, если хотите переместить поезд по маршруту вперед",
    "Введите 5, если хотите переместить поезд по маршруту назад",
    "Введите 0, если хотите закончить программу"
  ]

  def menu
    loop do
      puts MAIN_MENU
      main_choice = gets.chomp.to_i
      
      case main_choice
      when 1
        puts CREATE_MENU
        create_choice = gets.chomp.to_i
        case create_choice
        when 1
          create_station
        when 2
          create_train
        when 3
          create_vagon
        when 4
          create_route
        when 0
          break
        else
          puts "Введите цифру от 0 до 4"
        end

      when 2
        puts INFO_MENU
        info_choice = gets.chomp.to_i
        case info_choice
        when 1
          stations_list
        when 2
          trains_list
        when 3
          trains_list_on_station
        when 4
          vagons_list
        when 5
          routes_list
        when 0
          break
        else
          puts "Введите цифру от 0 до 4"
        end

      when 3
        puts OPERATION_MENU
        operation_choice = gets.chomp.to_i
        case operation_choice
        when 1
          puts ROUTE_MENU
          route_choice = gets.chomp.to_i
          case route_choice
          when 1
            add_station
          when 2
            delete_station
          when 0
            break
          else
            puts "Введите цифру от 0 до 2"
          end

        when 2
          puts TRAIN_MENU
          train_choice = gets.chomp.to_i
          case train_choice
          when 1
            set_route
          when 2
            add_vagon
          when 3
            delete_vagon
          when 4
            go_next_station
          when 5
            go_previous_station
          when 0
            break
          else
            puts "Введите цифру от 0 до 5"
          end

        when 0 
          break
        else
          puts "Введите цифру от 0 до 2"
        end

      when 0
        break
      else
        puts "Введите цифру от 0 до 3"
    end
  end
end

# это внутренние методы класса для вызова через текстовое меню, поэтому private
private

attr_writer :stations, :trains, :vagons, :routes

def create_station
  enter_station_name
  stations << @station if stations.none?(@station)
end

def create_train
  puts "Введите номер поезда"
  train_number = gets.chomp.to_i
  puts "Введите 1, если поезд пассажирский или 2, если поезд грузовой"
  train_type = gets.chomp.to_i
  
  return trains << TrainPassenger.new(train_number) if train_type == 1
  trains << TrainCargo.new(train_number)
end

def create_vagon
  puts "Введите 1, если хотите создать пассажирский или 2, если хотите создать грузовой вагон"
  type_vagon = gets.chomp.to_i

  return vagons << VagonPassenger.new if type_vagon == 1
  vagons << VagonCargo.new
end

def create_route
  puts "Введите название первой станции"
  start_station = gets.chomp

  puts "Введите название конечной станции"
  end_station = gets.chomp

  stations << start_station if stations.none?(start_station)
  stations << end_station if stations.none?(end_station)
  routes << Route.new(start_station, end_station)

end

def stations_list
  if check_stations
    stations.each_with_index { |station, index| puts "Индекс #{index}. #{station}" }
  else no_stations
  end
end

def trains_list
  if check_trains
    trains.each_with_index { |train, index| puts "Индекс #{index}. Номер #{train.number}: #{train.type}. Вагоны: #{train.vagons}. Маршрут: #{train.route}" }
  else no_trains
  end
end

def trains_list_on_station
  if choice_station
    if check_trains
      trains.each { |train| puts "Номер #{train.number}: #{train.type}" if train.current_station.eql?(stations[@choice_station_index]) }
    else no_trains
    end
  end
end

def vagons_list
  if check_vagons
    vagons.each_with_index { |vagon, index| puts "Индекс #{index}. #{vagon}: #{vagon.type}" }
  else no_vagons
  end
end

def routes_list
  if check_routes
    routes.each_with_index { |route, index| puts "Индекс #{index}. #{route.stations}" }
  else no_routes
  end
end

def add_station
  if choice_route
    enter_station_name
    stations << @station if stations.none?(@station)
    routes[@choice_route_index].add_station(@station)
  end
end

def delete_station
  if choice_route
    enter_station_name
    routes[@choice_route_index].delete_station(@station)
  end
end

def set_route
  if choice_train
    if choice_route
      trains[@choice_train_index].route=routes[@choice_route_index]
      puts "Текущая станция: #{trains[@choice_train_index].current_station}"
    end
  end
end

def add_vagon
  if choice_train
    if choice_vagon
      trains[@choice_train_index].add_vagons(vagons[@choice_vagon_index])
    end
  end
end

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
    puts "Текущая станция: #{trains[@choice_train_index].current_station}"
  else lets_set_route
  end
end

def go_previous_station
  if choice_train
    trains[@choice_train_index].go_previous_station
    puts "Текущая станция: #{trains[@choice_train_index].current_station}"
  else lets_set_route
  end
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
    puts "Выберите индекс станции"
    stations.each_with_index { |station, index| puts "#{index}. #{station}" }
    @choice_station_index = gets.chomp.to_i
  else no_stations
  end
end

def choice_train
  if check_trains
    puts "Выберите индекс поезда"
    trains.each_with_index { |train, index| puts "#{index}. #{train.number}: #{train.type}" }
    @choice_train_index = gets.chomp.to_i
  else no_trains
  end
end

def choice_vagon
  if check_vagons
    puts "Выберите индекс вагона"
    vagons.each_with_index { |vagon, index| puts "#{index}. #{vagon}" }
    @choice_vagon_index = gets.chomp.to_i
  else no_vagons
  end
end

def choice_route
  if check_routes
    puts "Выберите индекс маршрута"
    routes.each_with_index { |route, index| puts "#{index}. #{route.stations}" }
    @choice_route_index = gets.chomp.to_i
  else no_routes
  end
end

def enter_station_name
  puts "Введите название станции"
  @station = gets.chomp
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

def lets_set_route
  puts "Установите маршрут"
end

end
