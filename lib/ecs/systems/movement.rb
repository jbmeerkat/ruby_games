# frozen_string_literal: true

module ECS
  module Systems
    # Basic movement system
    class Movement < ECS::Systems::Base
      def process_tick(time_delta:)
        entities_with(:velocity, :position) do |entity|
          velocity = component(entity, :velocity)
          position = component(entity, :position)

          position.x = velocity.x * time_delta
          position.y = velocity.y * time_delta
        end
      end
    end
  end
end
