# frozen_string_literal: true

module Msgs
  # format
  TRAIN_NUMBER_FORMAT = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i.freeze
  VAGON_NUMBER_FORMAT = /^[0-9]{2,}$/
  TYPES = /^cargo$|^passenger$/i.freeze
  NAME_FORMAT = /\A[а-я|\w|\W]{2,}\z/i.freeze

  # errors_msgs
  NAME_ERROR = 'Name error'
  NUMBER_ERROR = 'Number error'
  TYPE_ERROR = 'Type error'
  INPUT_ERROR = 'Input error'
  SPACE_ERROR = 'Space error'
  SAME_STATIONS_ERROR = 'Same stations error'

  SPEED_ERROR = 'At first stop train'
  CARRIAGES_SIZE_ERROR = 'No cars to delete!'
  NOT_EMPTY_CAR_ERROR = 'This car is not empty!'
  ROUTE_ERROR = 'Route is not assigned'
  NEXT_STATION_ERROR = 'You are in the end station'
  PREVIOUS_STATION_ERROR = 'You are in the start station!'
  DELETE_STATION_ERROR = 'Impossible to delete start or last stations!'


  # stuff_msgs
  ITEM_ALREADY_EXISTS = 'Item already exists'
  NO_FREE_SPACE = 'No free space'
  NO_TRAINS_ERROR = 'No trains on station'
end
