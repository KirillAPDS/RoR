# frozen_string_literal: true

class TrainCargo < Train
  def initialize(company_name, number, type = :cargo)
    super
    validate_cargo!
  end

  protected

  def validate_cargo!
    raise TypeError, TYPE_ERROR if type !~ /^cargo$/
  end
end