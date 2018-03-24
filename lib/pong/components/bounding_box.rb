# frozen_string_literal: true

module Pong
  module Components
    # Simple bounding box
    class BoundingBox < ECS::Component
      attribute :rectangle, Types::Any
        .constrained(type: Pong::Components::Rectangle)

      def left_top
        Point[x: rectangle.x, y: rectangle.y]
      end

      def right_top
        Point[x: rectangle.x + rectangle.width, y: rectangle.y]
      end

      def right_bottom
        Point[x: rectangle.x + rectangle.width, y: rectangle.y + rectangle.height]
      end

      def left_bottom
        Point[x: rectangle.x, y: rectangle.y + rectangle.height]
      end
    end
  end
end
