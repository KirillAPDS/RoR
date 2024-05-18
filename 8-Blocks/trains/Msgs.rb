module Msgs

# format
  TRAIN_NUMBER_FORMAT = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i
  TYPES = /^cargo$|^passenger$/i

# errors_msgs
  NUMBER_ERROR = 'Train number error'
  TYPE_ERROR = 'Type error'
  
# stuff_msgs
  VAGON_ALREADY_EXISTS = 'Vagon already exists'

end