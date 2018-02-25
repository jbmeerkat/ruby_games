# frozen_string_literal: true

module Pong
  # Game configuration
  class Config < Dry::Struct
    # Config types
    module Types
      include Dry::Types.module

      Logger = Types::Any.constrained(type: Logger)
    end

    constructor_type :strict_with_defaults

    attribute :logger, Types::Logger.default(Logger.new(STDOUT))
    attribute :window_width, Types::Strict::Int
    attribute :window_height, Types::Int
    attribute :window_caption, Types::String.optional.default('Pong')
  end
end