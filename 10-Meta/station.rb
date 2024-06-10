# frozen_string_literal: true
 
class Station
  include InstanceCounter
  include Msgs
  include Validation
  extend Accessors
  
  attr_reader :name
  attr_accessor :trains

  @@stations = []

  def self.all
    @@stations
  end

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def initialize(name)
    @name = name
    @trains = []
    validate!
    same_validate!
    @@stations << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_block
    puts "На станции #{name} следующие поезда:"
    puts 'Поезда:'
    @trains.each do |train|
      puts "Номер поезда: #{train.number}. Тип: #{train.type}. Количество вагонов: #{train.vagons.size}."
    end
    puts
  end

  def info
    name.to_s
  end

  protected

  def same_validate!
    raise NameError, ITEM_ALREADY_EXISTS if @@stations.any? { |station| station.name == name }
  end
end
