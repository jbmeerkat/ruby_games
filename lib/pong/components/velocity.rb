# frozen_string_literal: true

module Pong
  module Components
    # Velocity component
    class Velocity < ECS::Component
      attribute :x, Types::Int.default(0)
      attribute :y, Types::Int.default(0)
      attribute :max, Types::Int.optional.default(nil)
    end
  end
end
