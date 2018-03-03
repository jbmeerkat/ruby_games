# frozen_string_literal: true

module ECS
  module Components
    # Position component
    class Position < ECS::Components::Base
      attribute :x, Types::Int.default(0)
      attribute :y, Types::Int.default(0)
    end
  end
end
