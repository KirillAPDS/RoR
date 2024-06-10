module Accessors
  def attr_accessor_with_history(*methods)
    history ||= []
    methods.each do |method|
      var_method = "#{method}_history".to_sym
      define_method(method) { instance_variable_get("@#{var_method}") }
      define_method(var_method) { instance_variable_get("@#{var_method}") }
      define_method("#{method}=".to_sym) { |value| instance_variable_set("@#{var_method}", history.push(value)) }
    end
  end

  def strong_attr_accessor(var_name, var_type)
    define_method(var_name) { instance_variable_get("@#{var_name}") }
    define_method("#{var_name}=") do |value|
      raise TypeError.new('variable type different than expected.') if var_name.class != var_type
      instance_variable_set("@#{var_name}", value)
    end
  end
end