# frozen_string_literal: true

module Pong
  module Systems
    # System that handles ball collisions
    class Ball < ECS::System
      run_on :update

      def run
        registry = world.entity_registry
        ball = registry.entities_by_tag[:ball].first
        velocity = registry.entity_component(ball, :velocity)
        return unless collides_with_horizontal_bounds?(ball)

        velocity.y = -velocity.y
      end

      private

      def collides_with_horizontal_bounds?(ball)
        registry = world.entity_registry
        rectangle = registry.entity_component(ball, :rectangle)

        rectangle.y + rectangle.height > world.height || rectangle.y.negative?
      end
    end
  end
end
