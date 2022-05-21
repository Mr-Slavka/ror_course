
  module Validation

    def self.included(base)
      base.extend ClassMethods
      base.include InstanceMethods
    end

    module ClassMethods
      attr_reader :validates

      def validate(attribute_name, validation_type, args = nil )
        @validates ||= []
        @validates << [ attribute_name, validation_type,  args ]
      end

    end

    module InstanceMethods

      def valid?
        validate!
        true
      rescue StandardError
        false
      end

      protected

      def validate!
        self.class.validates.each do |attribute_name, validation_type,  args|
          send (validation_type) ,send(attribute_name), args
        end
      end

      def presence(attribute_name, args)
        if attribute_name.is_a?(Integer)
          raise StandardError, "Attribute name cannot be empty #{attribute_name}" if attribute_name.nil?
        elsif attribute_name.is_a?(String)
          raise StandardError, "Attribute name cannot be empty #{attribute_name}" if attribute_name.empty?
        else
          raise StandardError, "Attribute name cannot be empty #{attribute_name}" if attribute_name.empty?
        end
      end

      def format(attribute_name, args)
        raise StandardError, "#{attribute_name} does not match the format" if attribute_name !~ args
      end

      def validation_type(attribute_name, args)
        raise StandardError, "Value #{attribute_name} is not a type #{args}" unless attribute_name.class == args
      end

      def length(attribute_name, args)
        raise StandardError, "#{attribute_name} must contain at least #{args} characters" if attribute_name.to_s.length < args
      end

    end

  end