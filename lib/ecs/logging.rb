# frozen_string_literal: true

module ECS
  # Logging helpers
  module Logging
    # :reek:UtilityFunction { enabled: false }
    def logger
      ECS.logger
    end
  end
end
