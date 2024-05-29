# frozen_string_literal: true

class VagonCargo < Vagon
  def initialize(number, space, type = :cargo)
    super
    validate_cargo!
  end

  protected

  def validate_cargo!
    raise TypeError, TYPE_ERROR if type !~ /^cargo$/
  end
end
