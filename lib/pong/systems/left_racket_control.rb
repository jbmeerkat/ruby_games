# frozen_string_literal: true

module Pong
  module Systems
    # Basic movement system
    class LeftRacketControl < ECS::System
      watch_components :left_racket, :velocity
      run_on :update

      def process_entity(_entity, _racket, velocity)
        height = world.height

        velocity.y = if Gosu.button_down?(Gosu::KB_S)
          height * 0.5
        elsif Gosu.button_down?(Gosu::KB_W)
          -height * 0.5
        else
          0
        end
      end
    end
  end
end
