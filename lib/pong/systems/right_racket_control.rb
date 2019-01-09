# frozen_string_literal: true

module Pong
  module Systems
    # Basic movement system
    class RightRacketControl < ECS::System
      watch_components :right_racket, :velocity
      run_on :update

      def process_entity(_entity, _racket, velocity)
        height = world.height

        velocity.y = if Gosu.button_down?(Gosu::KB_DOWN)
          height * 0.5
        elsif Gosu.button_down?(Gosu::KB_UP)
          -height * 0.5
        else
          0
        end
      end
    end
  end
end
