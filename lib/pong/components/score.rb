# frozen_string_literal: true

module Pong
  module Components
    # Represents players scores
    class Score < ECS::Component
      attribute :left, Types::Integer.default(0)
      attribute :right, Types::Integer.default(0)

      def add_left
        self.left += 1
      end

      def add_right
        self.right += 1
      end
    end
  end
end
