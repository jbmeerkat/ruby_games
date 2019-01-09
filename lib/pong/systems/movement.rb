# frozen_string_literal: true

module Pong
  module Systems
    # Basic movement system
    class Movement < ECS::System
      watch_components :velocity, :rectangle
      run_on :update

      def process_entity(_entity, velocity, rectangle)
        delta_sec = world.time_delta / 1000.0
        position = rectangle.position

        position.x += (velocity.x * delta_sec).round
        position.y += (velocity.y * delta_sec).round

        handle_world_bounds(velocity, rectangle)
      end

      private

      def handle_world_bounds(velocity, rectangle)
        position = rectangle.position
        return if position.bypass_world_bounds?
        return unless position.stop_on_world_bounds?

        process_collision(velocity, rectangle)
      end

      def process_collision(velocity, rectangle)
        if crossing_upper_bound?(rectangle)
          position.y = 0
          velocity.y = 0
        elsif crossing_lower_bound?(rectangle)
          position.y = world.height - rectangle.height
          velocity.y = 0
        end
      end

      def crossing_upper_bound?(rectangle)
        rectangle.y.negative?
      end

      def crossing_lower_bound?(rectangle)
        rectangle.y + rectangle.height > world.height
      end
    end
  end
end
