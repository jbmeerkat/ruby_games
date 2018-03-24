# frozen_string_literal: true

# Simple point
class Point < Dry::Struct::Mutable
  attribute :x, Dry::Types['int']
  attribute :y, Dry::Types['int']
end
