=begin
  
Класс Station (Станция):
• Имеет название, которое указывается при ее создании
• Может принимать поезда (по одному за раз)
• Может возвращать список всех поездов на станции, 
  находящиеся в текущий момент
• Может возвращать список поездов на станции по типу (см. ниже): 
  кол-во грузовых, пассажирских
• Может отправлять поезда (по одному за раз, при этом, 
  поезд удаляется из списка поездов, находящихся на станции).

=end

class Station
  attr_reader :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

# добавление одного поезда
  def get_train(train)
    self.trains << train
  end

# список всех поездов на станции в текущий момент
  def trains_list
    puts "Сейчас на станции эти поезда:"
    puts trains
  end

# список поездов на станции по типу в текущий момент
  def trains_list_by_type(type)
    self.trains.each do |train|
      if train.type == type
        puts train
      end
    end
  end

# отправление поезда
  def send_train(train)
    puts "Отправили этот поезд: #{train}"
    self.trains.delete(train)
  end
  
end