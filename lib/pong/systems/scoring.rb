# frozen_string_literal: true

module Pong
  module Systems
    # Calculates score depending on ball position
    class Scoring < ECS::System
      run_on :update

      def run
        if crossed_left_bound?
          score.add_right
          reset_ball
        elsif crossed_right_bound?
          score.add_left
          reset_ball
        end
      end

      private

      def crossed_left_bound?
        rectangle.position.x.negative?
      end

      def crossed_right_bound?
        rectangle.position.x + rectangle.width > world.width
      end

      def reset_ball
        component(:rectangle).yield_self do |rectangle|
          rectangle.position.x = world.width / 2
          rectangle.position.y = world.height / 2
        end
      end

      def rectangle
        component(:rectangle)
      end

      def score
        entity = entity_registry.entities_by_tag[:score].first
        entity_registry.entity_component(entity, :score)
      end

      def component(name)
        entity_registry.entity_component(ball, name)
      end

      def ball
        entity_registry.entities_by_tag[:ball].first
      end
    end
  end
end
