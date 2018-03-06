# frozen_string_literal: true

module Dry
  class Struct
    # dry-struct with attribute writers
    class Mutable < Struct
      constructor_type :schema

      def self.attributes(new_schema)
        super

        new_schema.each_key do |key|
          define_method("#{key}=") do |value|
            instance_variable_set("@#{key}", self.class.schema[key][value])
          end
        end

        self
      end
    end
  end
end
