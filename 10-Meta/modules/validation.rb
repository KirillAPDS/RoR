# frozen_string_literal: true

module Validation
  
  NAME_FORMAT = /\A[а-я|\w|\W]{2,}\z/i.freeze
  TRAIN_NUMBER_FORMAT = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i.freeze
  VAGON_NUMBER_FORMAT = /^[0-9]{2,}$/
  TYPES = /^cargo$|^passenger$/i.freeze

  def self.included(base)
    base.extend ClassValidation
    base.include InstanceValidation
  end

  module ClassValidation
    attr_accessor :validations

    def validations
      @validations ||= []
    end

    def validate(name, type, *options)
      validations << { name: name, type: type, options: options }
    end
  end

  module InstanceValidation
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.validations.each do |item|
        validation = "#{item[:type]}"
        
        option = item[:options]
        item = instance_variable_get("@#{item[:name]}".to_sym)
        send(validation, item, *option)
      end
    end

    def presence(value, *options)
      raise 'Name can not be nil' if value.nil? || value.strip.empty?
    end

    def format(value, format)
      raise 'Format error' if value !~ format #unless format.match?(value.to_s)
    end

    def type_format(value, type_format)
      raise 'Type error' if value !~ type_format #unless value.is_a?(type)
    end

    # def same(value, item)
    #   raise 'Same object' unless value == item
    # end
  end
end