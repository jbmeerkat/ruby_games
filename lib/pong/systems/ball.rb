# frozen_string_literal: true

module Pong
  module Systems
    class Ball < ECS::System
      run_on :update

      def run
        registry = world.entity_registry
        ball = registry.entities_by_tag[:ball].first
        velocity = registry.entity_component(ball, :velocity)
        rectangle = registry.entity_component(ball, :rectangle)

        if rectangle.y + rectangle.height > world.height || rectangle.y < 0
          velocity.y = -velocity.y
        end
      end
    end
  end
end
