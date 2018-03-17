# frozen_string_literal: true

module Pong
  module Systems
    # Rendering rectangles
    class RenderRectangle < ECS::System
      watch_components :rectangle
      run_on :draw

      def process_entity(_entity, rectangle)
        Gosu.draw_rect(
          rectangle.x,
          rectangle.y,
          rectangle.width,
          rectangle.height,
          Gosu::Color::WHITE
        )
      end
    end
  end
end
