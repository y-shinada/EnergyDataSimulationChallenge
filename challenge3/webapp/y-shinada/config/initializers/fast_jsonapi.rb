module ActiveRecord
  module FastJsonApiExtension
    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end

    module ClassMethods
      def serializer_name
        "#{self.name}Serializer"
      end

      def serializer(rows, options: {})
        serializer_name.safe_constantize&.new(rows, options)
      end
    end

    module InstanceMethods
      def serializer
        self.class.serializer_name.safe_constantize&.new(self)
      end
    end
  end

  Base.include(FastJsonApiExtension)
end
