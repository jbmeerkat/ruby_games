# frozen_string_literal: true

module ECS
  module Systems
    # Basic movement system
    class Movement < ECS::System
      watch_components :velocity, :position
      run_on :update

      def process_entity(_entity, velocity, position)
        delta_sec = world.time_delta / 1000.0

        position.x = velocity.x * delta_sec
        position.y = velocity.y * delta_sec
      end
    end
  end
end
