  module Accessors
    def attr_accessor_with_history(*attributes)
      attributes.each do |attr|
        attribute = "@#{attr}".to_sym
        define_method(attr) { instance_variable_get(attribute) }
        define_method("#{attr}=".to_sym) do |value|
          instance_variable_set(attribute, value)
          @history ||= {}
          @history[attr] ||= []
          @history[attr] << value
        end
        define_method("#{attr}_history") { @history[attr.to_sym] }
      end
    end

    def strong_attr_accessor(*attributes)
      attributes.each do |attr_name|
        var_name = "@#{attr_name}".to_sym
        define_method(attr_name) { instance_variable_get(var_name) }
        define_method("set_#{attr_name}".to_sym) do |value, class_type|
          raise "Value is not a class #{class_type}" if value.class != class_type

          instance_variable_set(var_name, value)
        end
      end
    end
  end
