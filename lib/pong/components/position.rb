# frozen_string_literal: true

module Pong
  module Components
    # Position component
    class Position < ECS::Component
      attribute :x, Types::Integer.default(0)
      attribute :y, Types::Integer.default(0)
      attribute :on_world_bounds, Types::Symbol.default(:bypass)
        .enum(:bypass, :stop)

      def bypass_world_bounds?
        on_world_bounds == :bypass
      end

      def stop_on_world_bounds?
        on_world_bounds == :stop
      end
    end
  end
end
