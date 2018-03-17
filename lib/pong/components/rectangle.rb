# frozen_string_literal: true

module Pong
  module Components
    # Component for rectangle description
    class Rectangle < ECS::Component
      extend Forwardable

      attribute :position,
        Types::Any.constrained(type: Pong::Components::Position)
      attribute :width, Types::Int.default(20)
      attribute :height, Types::Int.default(10)

      def_delegators :position, :x
      def_delegators :position, :y
    end
  end
end
