# frozen_string_literal: true

class TrainPassenger < Train
  def initialize(number, type = :passenger)
    super
    validate_passenger!
  end

  protected

  def validate_passenger!
    raise TypeError, TYPE_ERROR if type !~ /^passenger$/
  end
end
