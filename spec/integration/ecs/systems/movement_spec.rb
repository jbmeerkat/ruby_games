# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::System do
  class MovementSystem < described_class
    watch_components :velocity, :position
    run_on :update

    def process_entity(_entity, velocity, position)
      delta_sec = world.time_delta / 1000.0

      position.x = velocity.x * delta_sec
      position.y = velocity.y * delta_sec
    end
  end

  class Position < ECS::Component
    attribute :x, Types::Int.default(0)
    attribute :y, Types::Int.default(0)
  end

  class Velocity < ECS::Component
    attribute :x, Types::Int.default(0)
    attribute :y, Types::Int.default(0)
    attribute :max, Types::Int.optional.default(nil)
  end

  subject(:position) { registry.entity_component(entity, :position) }

  let(:world) { ECS::World.new(width: 100, height: 100) }
  let(:registry) { world.entity_registry }
  let(:entity) { world.create_entity }
  let(:position_component) { Position[x: 0, y: 0] }
  let(:velocity_component) { Velocity[x: 10, y: 10] }
  let(:system) { MovementSystem.new }
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
