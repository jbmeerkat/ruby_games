# frozen_string_literal: true

module Pong
  module Components
    # Component for rectangle description
    class Rectangle < ECS::Components::Base
      attribute :x, Types::Int.default(0)
      attribute :y, Types::Int.default(0)
      attribute :width, Types::Int.default(20)
      attribute :height, Types::Int.default(10)
    end
  end
end
