# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Components::Position do
  subject(:position) do
    described_class.new(x: x, y: y, on_world_bounds: bounds_reaction)
  end

  let(:x) { 10 }
  let(:y) { 10 }
  let(:bounds_reaction) { %i[bypass stop].sample }

  it 'has coordinates and reaction to world bounds' do
    expect(position).to have_attributes(
      x: 10, y: 10, on_world_bounds: bounds_reaction
    )
  end
end
