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
          play_collision_sound
        elsif collides_with_racket?
          velocity.x = -velocity.x
          play_collision_sound
        end
      end

      private

      def collides_with_horizontal_bounds?
        rectangle = rectangle_by_tag(:ball)

        rectangle.y + rectangle.height > world.height || rectangle.y.negative?
      end

      def collides_with_racket?
        ball = rectangle_by_tag(:ball)
        left_racket = rectangle_by_tag(:left_racket)
        right_racket = rectangle_by_tag(:right_racket)

        rectangle_collision?(ball, left_racket) ||
          rectangle_collision?(ball, right_racket)
      end

      # :reek:DuplicateMethodCall
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

      def play_collision_sound
        sound.play
      end

      def sound
        @sound ||= Gosu::Sample.new('assets/sounds/ball_collision.wav')
      end
    end
  end
end
