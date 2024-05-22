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
    'Купить билет / занять объём'
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
      when '9' then vagons_with_trains
      when '10' then routes_list
      when '11' then add_vagon_to_train
      when '12' then delete_vagon_from_train
      when '13' then reserve
      when '14' then add_station_to_route
      when '15' then delete_station_from_route
      when '16' then assign_route
      when '15' then go_next_station
      when '16' then go_previous_station
      when '0' then exit
      else input_error
      end
    end
  end
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
      when '3' then stations_with_trains
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
