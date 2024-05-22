class Station
  include InstanceCounter
  include Validation
  include Msgs

  attr_reader :name
  attr_accessor :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.count{ |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_detailed(&block)
    block.call
  end

  def trains_block
    puts "На станции #{self.name} следующие поезда:"
    puts "Поезда:"
    @trains.each { |train| puts "Номер поезда: #{train.number}. Тип: #{train.type}. Количество вагонов: #{train.vagons}." } 
    puts
  end

  protected

  def validate!
    raise NameError, NAME_ERROR if name.nil? || name.length.zero?
    raise NameError, ITEM_ALREADY_EXISTS if @@stations.any? { |station| station.name == name }
  end

  def trains_on_station_validate!
    raise NO_TRAINS_ERROR if @trains.empty?
  end
end