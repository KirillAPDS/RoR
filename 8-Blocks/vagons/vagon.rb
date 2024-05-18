class Vagon
  include CompanyName
  include Validation
  include Msgs

  attr_accessor :company_name, :number, :space, :reserved, :type

  def initialize(number, type)
    @number = number
    @type = type
    @reserved = 0
    validate!
  end

  def take_space(space)
    if @reserved + space > @space
      puts 'Нет свободного места'
    else 
      @reserved += space
      puts "Успешный резерв. Свободно: #{available_space}. Занято: #{@reserved}"
    end
  end

  def available_space
    @space - @reserved
  end

  protected

  def validate!
    raise RuntimeError, NUMBER_ERROR if !Integer(@number, exception: false)
    raise TypeError, TYPE_ERROR if type !~ TYPES
    space_input
    raise TypeError, NUMBER_ERROR if !Integer(@space, exception: false)
  end

  def space_input
    puts "Введите количество мест / объём"
    @space = gets.chomp.to_i
  end
end