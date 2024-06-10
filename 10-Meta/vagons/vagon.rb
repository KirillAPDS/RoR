# frozen_string_literal: true

class Vagon
  include CompanyName
  include InstanceCounter
  include Msgs
  include Validation
  extend Accessors

  attr_accessor :name, :number, :space, :reserved
  attr_reader :type

  @@vagons = []
  
  # validate :number, :presence
  # validate :type, :presence
  # validate :number, :format, VAGON_NUMBER_FORMAT

  validate :name, :presence
  validate :number, :format, VAGON_NUMBER_FORMAT
  validate :type, :type_format, TYPES

  def initialize(name, number, type, space)
    @name = name
    @number = number
    @type = type
    validate!
    @space = space
    @reserved = 0
    @@vagons << self
    register_instance
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
