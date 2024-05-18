class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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