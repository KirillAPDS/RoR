class VagonCargo < Vagon

  def initialize(number, type = :cargo, space)
    super
    validate_cargo!
  end

  protected

  def validate_cargo!
    raise TypeError, TYPE_ERROR if type !~ /^cargo$/
  end
end