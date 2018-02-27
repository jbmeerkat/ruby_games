# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::Components::Position do
  let(:x) { 10 }
  let(:y) { 10 }

  subject(:position) { described_class.new(x: x, y: y) }

  it 'has coordinates' do
    expect(position).to have_attributes x: 10, y: 10
  end
end
