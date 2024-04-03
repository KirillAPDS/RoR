require_relative 'modules/company_name.rb'

class Vagon
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
