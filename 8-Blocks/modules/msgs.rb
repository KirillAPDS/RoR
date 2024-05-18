module Msgs

# format
  TRAIN_NUMBER_FORMAT = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i
  TYPES = /^cargo$|^passenger$/i

# errors_msgs
  NAME_ERROR = 'Name error'
  NUMBER_ERROR = 'Number error'
  TYPE_ERROR = 'Type error'
  INPUT_ERROR = 'Input error'
  
# stuff_msgs
  ITEM_ALREADY_EXISTS = 'This item is already exists'
  NO_FREE_SPACE = 'No free space'
  NO_TRAINS_ERROR = 'No trains on station'
end