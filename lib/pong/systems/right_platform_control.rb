# frozen_string_literal: true

module Pong
  module Systems
    # Basic movement system
    class RightPlatformControl < ECS::System
      watch_components :right_platform, :velocity
      run_on :update

      def process_entity(_entity, _right_platform, velocity)
        if Gosu.button_down?(Gosu::KB_DOWN)
          velocity.y += 10
        elsif Gosu.button_down?(Gosu::KB_UP)
          velocity.y -= 10
        else
          velocity.y = 0
        end
      end
    end
  end
end
