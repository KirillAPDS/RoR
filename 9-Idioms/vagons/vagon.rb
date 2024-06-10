# frozen_string_literal: true

class Vagon
  include CompanyName
  include Validation
  include Msgs

  attr_accessor :company_name, :number, :space, :reserved, :type

  def initialize(number, space, type)
    @number = number
    @space = space
    @type = type
    @reserved = 0
    validate!
  end

  def take_space(space)
    if @reserved + space > @space
      puts 'Нет свободного места'
    else
      @reserved += space
      puts "Успешный резерв. #{info}"
    end
  end

  def available_space
    @space - @reserved
  end

  def info
    "Номер вагона: #{number}. Тип: #{type}. Свободно: #{available_space}. Занято: #{@reserved}"
  end

  protected

  def validate!
    raise NUMBER_ERROR unless Integer(@number, exception: false)
    raise SPACE_ERROR unless Integer(@space, exception: false)
    raise TypeError, TYPE_ERROR if type !~ TYPES
  end
end
