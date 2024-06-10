# frozen_string_literal: true

class VagonPassenger < Vagon
  def initialize(company_name, number, space, type = :passenger)
    super
    validate_passenger!
  end

  def take_space
    super(1)
  end

  protected

  def validate_passenger!
    raise TypeError, TYPE_ERROR if type !~ /^passenger$/
  end
end

#  attr_accessor :seats
# seats_input
# @seats = {all: seats, used: 0}

# def seats_input
#   puts "Введите количество мест"
#   @seats = gets.chomp.to_i
# end

# def busy_seats
#   seats[:used]
# end

# def available_seats
#   seats[:all] - seats[:used]
# end

# def all_seats
#   seats[:all]
# end

# def take_seat
#   if seats[:used] + 1 > seats[:all]
#     puts 'Мест нет'
#   else
#     seats[:used] += 1
#     puts "Билет куплен. Свободно мест: #{available_seats}. Занято мест: #{busy_seats}"
#   end
# end
