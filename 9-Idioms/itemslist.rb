# frozen_string_literal: true

	@stations = [1, 2]
  @trains = []
  @vagons = []
  @routes = []

	def items_list(items, items_name)
    if items.empty?
      puts "No #{items_name}"
    else
      items.each_with_index { |item, index| puts "#{index}. #{item}" }
    end
  end

	stations_list = items_list(@stations, 'stations')
  trains_list = items_list(@trains, 'trains')
  vagons_list = items_list(@vagons, 'vagons')
  routes_list = items_list(@routes, 'routes')

	stations_list
