class VagonCargo < Vagon

  def initialize(number, type = :cargo)
    super
    validate_cargo!
  end

  protected

  def validate_cargo!
    raise TypeError, TYPE_ERROR if type !~ /^cargo$/
  end
end


  # volume[:used] + vol > volume[:total] ? 'Нет свободного места' : volume[:used] += vol
  # (available_volume - vol).negative? ? 'Нет свободного места' : volume[:used] += vol

