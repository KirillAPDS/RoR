require_relative 'modules/instance_counter.rb'

class Station
  include InstanceCounter
  
  attr_reader :trains
  attr_accessor :name

  @@stations = []
  NAME_ERROR = "Name can't be nil"

  def initialize(name)
    @name = name
    validate!
    @trains = []
    register_instance
  end

  def self.all
    @@stations
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

  def validate!
    raise RuntimeError, NAME_ERROR if @name.empty?
    puts "Станция #{@station} создана"
  end
end










=begin
  # trains.each do |train|
        #   puts train

# trains.select { |train| train.include? type }

    # trains.each do |train|
    #   if train.type == type
    #     puts train
    #   else
    #     puts "Поездов типа #{type} сейчас на станции нет"
    #   end
    # end


    # список всех поездов на станции в текущий момент
  # def trains_list
  #   if trains.size == 0
  #     puts "Сейчас на станции #{@name} поездов нет"
  #   else
  #     puts "Сейчас на станции эти поезда:"
  #     puts trains
  #   end
  # end

  if type_count > 0
      puts "Количество поездов типа #{type} на станции #{@name}: #{type_count}"
      
      type_count = @trains.count { |train| train.type == type }

      else 
      puts "На станции #{@name} сейчас нет поездов типа #{type}"
=end