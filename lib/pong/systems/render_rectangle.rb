# frozen_string_literal: true

module Pong
  module Systems
    # Rendering rectangles
    class RenderRectangle < ECS::System
      def process_tick(_)
        entities_with(:rectangle) do |_, rectangle|
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
end
