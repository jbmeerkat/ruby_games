# frozen_string_literal: true

module ECS
  module Systems
    # Basic movement system
    class Movement < ECS::Systems::Base
      def process_tick(time_delta:)
        delta_sec = time_delta / 1000.0

        entities_with(:velocity, :position) do |_entity, velocity, position|
          position.x = velocity.x * delta_sec
          position.y = velocity.y * delta_sec
        end
      end
    end
  end
end
