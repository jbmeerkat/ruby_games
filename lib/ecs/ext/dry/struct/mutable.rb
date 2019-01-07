# frozen_string_literal: true

module Dry
  class Struct
    # dry-struct with attribute writers
    class Mutable < Struct
      def self.attributes(new_schema)
        super

        new_schema.each_key do |key|
          define_method("#{key}=") do |value|
            @attributes[key] = value
          end
        end

        self
      end
    end
  end
end
