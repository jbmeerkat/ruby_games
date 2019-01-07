# frozen_string_literal: true

require 'securerandom'
require 'active_support/inflector/methods'

module ECS
  # Basic component
  class Component < Dry::Struct::Mutable
    # Basic component types
    module Types
      include Dry::Types.module

      Id = Types::String.default { SecureRandom.uuid }
    end

    attribute :id, Types::Id

    def name
      name = self.class.name.split('::').last
      ActiveSupport::Inflector.underscore(name).to_sym
    end
  end
end
