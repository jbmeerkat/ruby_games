# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::Systems::Movement do
  subject(:position) { registry.entity_component(entity, :position) }

  let(:world) { ECS::World.new(width: 100, height: 100) }
  let(:registry) { world.entity_registry }
  let(:entity) { world.create_entity }
  let(:position_component) do
    ECS::Components::Position[x: 0, y: 0]
  end
  let(:velocity_component) do
    ECS::Components::Velocity[x: 10, y: 10]
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
    ).from(0).to(10).and change(
      position, :y
    ).from(0).to(10)
  end
end
