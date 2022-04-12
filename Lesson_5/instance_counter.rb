
  module InstanceCounter

    def self.included(base)

      base.extend ClassMethods
      base.include InstanceMethods

    end

    module ClassMethods
      attr_accessor  :instances
    end


    module InstanceMethods

      protected

      def register_instance
        if self.class.instances.nil?
          self.class.instances = 0
          self.class.instances += 1
        else
          self.class.instances += 1
        end
      end
    end


  end
