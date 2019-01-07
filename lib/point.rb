# frozen_string_literal: true

# Simple point
class Point < Dry::Struct::Mutable
  attribute :x, Dry::Types['integer']
  attribute :y, Dry::Types['integer']
end
