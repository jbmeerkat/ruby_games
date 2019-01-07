# frozen_string_literal: true

module Pong
  module Components
    # Component for rectangle description
    class Rectangle < ECS::Component
      extend Forwardable

      attribute :position,
        Types::Any.constrained(type: Pong::Components::Position)
      attribute :width, Types::Integer.default(20)
      attribute :height, Types::Integer.default(10)

      def_delegators :position, :x
      def_delegators :position, :y

      def top_y
        y
      end

      def bottom_y
        y + height
      end
    end
  end
end
