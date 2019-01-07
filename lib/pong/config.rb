# frozen_string_literal: true

module Pong
  # Game configuration
  class Config < Dry::Struct
    # Config types
    module Types
      include Dry::Types.module

      Logger = Types::Any.constrained(type: Logger)
    end

    attribute(:logger, Types::Logger.default { ::Logger.new(STDOUT) })
    attribute :window_width, Types::Strict::Integer
    attribute :window_height, Types::Integer
    attribute :window_caption, Types::String.optional.default('Pong')
  end
end
