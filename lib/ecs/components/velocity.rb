# frozen_string_literal: true

module ECS
  module Components
    # Velocity component
    class Velocity < ECS::Components::Base
      attribute :x, Types::Int.default(0)
      attribute :y, Types::Int.default(0)
      attribute :max, Types::Int.optional.default(nil)
    end
  end
end
