class Vagon
  include CompanyName
  include Validation
  include Msgs

  attr_accessor :company_name, :number, :space, :reserved
  attr_reader :type

  def initialize(number, type, space)
    @number = number
    @type = type
    @space = space
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
    raise RuntimeError, SPACE_ERROR if !Integer(@space, exception: false)
  end
end