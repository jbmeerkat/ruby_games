# frozen_string_literal: true

require 'securerandom'

module ECS
  module Components
    # Basic component
    class Base < Dry::Struct
      # Basic component types
      module Types
        include Dry::Types.module

        Id = Types::String.default { SecureRandom.uuid }
      end

      constructor_type :strict_with_defaults

      attribute :id, Types::Id
    end
  end
end
