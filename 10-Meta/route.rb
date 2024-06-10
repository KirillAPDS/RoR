# frozen_string_literal: true

class Route
  include InstanceCounter

  @@stations = []

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def info
    stations.to_s
  end
end
