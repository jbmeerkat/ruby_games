# frozen_string_literal: true

module Pong
  module Components
    # Position component
    class Position < ECS::Component
      attribute :x, Types::Int.default(0)
      attribute :y, Types::Int.default(0)
    end
  end
end
