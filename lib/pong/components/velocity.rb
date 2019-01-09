# frozen_string_literal: true

module Pong
  module Components
    # Velocity component
    class Velocity < ECS::Component
      attribute :x, Types::Integer.default(0)
      attribute :y, Types::Integer.default(0)
      attribute :max, Types::Integer.default(9999)
    end
  end
end
