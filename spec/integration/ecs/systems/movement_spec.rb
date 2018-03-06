# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::Systems::Movement do
  let(:registry) { ECS::EntityRegistry.new }
  let(:entity) { registry.create_entity }
  let(:position_component) do
    ECS::Components::Position[x: 0, y: 0]
  end
  let(:velocity_component) do
    ECS::Components::Velocity[x: 10, y: 10]
  end
  let(:system) { described_class.new(entities_registry: registry) }

  subject(:tick) { system.run(time_delta: 1000) }
  subject(:position) { registry.entity_component(entity, :position) }

  before do
    registry.add_component(entity, position_component)
    registry.add_component(entity, velocity_component)
  end

  it 'moves entity' do
    expect { tick }.to change {
      position.x
    }.from(0).to(10).and change {
      position.y
    }.from(0).to(10)
  end
end
