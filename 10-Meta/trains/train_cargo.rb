# frozen_string_literal: true

class TrainCargo < Train
  # include CompanyName
  # include InstanceCounter
  # include Msgs
  # include Validation
  # extend Accessors

  validate :name, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT
  validate :type, :type_format, TYPES

  def initialize(company_name, number, type = :cargo)
    super
    validate_cargo!
  end

  protected

  def validate_cargo!
    raise TypeError, TYPE_ERROR if type !~ /^cargo$/
  end
end
