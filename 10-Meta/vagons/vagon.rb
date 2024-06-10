# frozen_string_literal: true

class Vagon
  include CompanyName
  include Msgs
  include Validation
  extend Accessors

  attr_accessor :company_name, :number, :space, :reserved
  attr_reader :type

  validate :company_name, :presence
  validate :number, :presence
  validate :type, :presence

  validate :company_name, :format, NAME_FORMAT
  validate :number, :format, VAGON_NUMBER_FORMAT
  validate :type, :format, TYPES

  def initialize(company_name, number, type, space)
    @company_name = company_name
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

  # protected

  # def validate!
  #   raise NUMBER_ERROR.to_s unless Integer(@number, exception: false)
  #   raise TypeError, TYPE_ERROR if type !~ TYPES
  #   raise SPACE_ERROR.to_s unless Integer(@space, exception: false)
  # end
end
