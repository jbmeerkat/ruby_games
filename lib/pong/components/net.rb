# frozen_string_literal: true

module Pong
  module Components
    # Contains data needed for net rendering
    class Net < ECS::Component
      attribute :section_length, Types::Integer.default(10)
      attribute :section_width, Types::Integer.default(3)
      attribute :sections, Types::Integer.default(0)
    end
  end
end
