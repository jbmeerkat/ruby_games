# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Systems::Movement do
  subject(:position) { registry.entity_component(entity, :position) }

  let(:world) { ECS::World.new(width: 100, height: 100) }
  let(:registry) { world.entity_registry }
  let(:entity) { world.create_entity }
  let(:position_component) do
    Pong::Components::Position[x: 10, y: 10]
  end
  let(:velocity_component) do
    Pong::Components::Velocity[x: 10, y: 10]
  end
  let(:system) { described_class.new }
  let(:tick) { system.run }

  before do
    world.time_delta = 1000
    system.world = world

    registry.add_component(entity, position_component)
    registry.add_component(entity, velocity_component)
  end

  it 'moves entity' do
    expect { tick }.to change(
      position, :x
    ).from(10).to(20).and change(
      position, :y
    ).from(10).to(20)
  end
end
