# frozen_string_literal: true

module Pong
  module Systems
    # System that handles ball collisions
    class Ball < ECS::System
      run_on :update

      def_delegator :world, :entity_registry

      def run
        ball = entity_registry.entities_by_tag[:ball].first
        velocity = entity_registry.entity_component(ball, :velocity)

        if collides_with_horizontal_bounds?
          velocity.y = -velocity.y
        elsif collides_with_platform?
          velocity.x = -velocity.x
        end
      end

      private

      def collides_with_horizontal_bounds?
        rectangle = rectangle_by_tag(:ball)

        rectangle.y + rectangle.height > world.height || rectangle.y.negative?
      end

      def collides_with_platform?
        ball = rectangle_by_tag(:ball)
        left_platform = rectangle_by_tag(:left_platform)
        right_platform = rectangle_by_tag(:right_platform)

        rectangle_collision?(ball, left_platform) ||
          rectangle_collision?(ball, right_platform)
      end

      def rectangle_collision?(first, second) # rubocop:disable Metrics/AbcSize
        first.x < second.x + second.width &&
          first.x + first.width > second.x &&
          first.y < second.y + second.height &&
          first.y + first.height > second.y
      end

      def rectangle_by_tag(tag)
        entity = entity_registry.entities_by_tag[tag].first
        entity_rectangle(entity)
      end

      def entity_rectangle(entity)
        entity_registry.entity_component(entity, :rectangle)
      end
    end
  end
end
