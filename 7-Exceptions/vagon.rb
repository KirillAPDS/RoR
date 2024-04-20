require_relative 'modules/company_name.rb'
require_relative 'modules/validation.rb'

class Vagon
  include CompanyName
  include Validation

  attr_accessor :type

  TYPES = /^cargo$|^passenger$/i
  TYPE_ERROR = 'Type error'

  def initialize(type)
    @type = type
    validate!
  end

  protected

  def validate!
    raise TypeError, TYPE_ERROR if type !~ TYPES
    puts "#{type} вагон создан"
  end
end