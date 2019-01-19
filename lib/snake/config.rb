# frozen_string_literal: true

module Snake
  # Main game configuration
  class Config < Dry::Struct
    # Configuration types
    module Types
      include Dry::Types.module

      Logger = Types::Any.constrained(type: Logger)
        .default { Logger.new(STDOUT) }
    end

    attribute :logger, Types::Logger
    attribute :window, Types::Any
    attribute :window_caption, Types::Strict::String.default('Snake')
  end
end
