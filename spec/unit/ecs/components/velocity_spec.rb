# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::Components::Velocity do
  let(:x) { 10 }
  let(:y) { 10 }

  subject(:velocity) { described_class.new(x: x, y: y) }

  it 'has velocity values' do
    expect(velocity).to have_attributes x: 10, y: 10, max: nil
  end
end
