# frozen_string_literal: true

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
      puts 'Успешный резерв.'
      info
    end
  end

  def available_space
    @space - @reserved
  end

  def info
    "Номер: #{number}. Тип: #{type}. Свободно: #{available_space}. Занято: #{@reserved}"
  end

  protected

  def validate!
    raise NUMBER_ERROR.to_s unless Integer(@number, exception: false)
    raise TypeError, TYPE_ERROR if type !~ TYPES
    raise SPACE_ERROR.to_s unless Integer(@space, exception: false)
  end
end
