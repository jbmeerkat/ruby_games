# frozen_string_literal: true

module Pong
  module Systems
    # Basic movement system
    class LeftPlatformControl < ECS::System
      watch_components :left_platform, :velocity
      run_on :update

      def process_entity(_entity, _left_platform, velocity)
      end
    end
  end
end

