# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Systems::Movement do
  let(:world) { ECS::World.new(width: 100, height: 100) }
  let(:registry) { world.entity_registry }
  let(:entity) { world.create_entity }
  let(:rectangle) do
    Pong::Components::Rectangle[
      position: position,
      width: 10,
      height: 10
    ]
  end
  let(:position) do
    Pong::Components::Position[x: 10, y: 10]
  end
  let(:velocity) do
    Pong::Components::Velocity[x: 10, y: 10]
  end
  let(:system) { described_class.new }
  let(:tick) { system.run }

  before do
    world.time_delta = 1000
    system.world = world

    registry.add_component(entity, rectangle)
    registry.add_component(entity, velocity)
  end

  it 'moves entity' do
    expect { tick }.to change(
      rectangle.position, :x
    ).from(10).to(20).and change(
      rectangle.position, :y
    ).from(10).to(20)
  end

  describe 'world bounds handling' do
    context 'when stop on upper' do
      let(:velocity) { Pong::Components::Velocity[x: 0, y: -10] }
      let(:position) do
        Pong::Components::Position[x: 0, y: 5, on_world_bounds: :stop]
      end

      it 'restricts moving' do
        expect { tick }.to change(
          velocity, :y
        ).to(0).and change(
          position, :y
        ).to(0)
      end
    end

    context 'when stop on lower' do
      let(:velocity) { Pong::Components::Velocity[x: 0, y: 10] }
      let(:position) do
        Pong::Components::Position[x: 0, y: 91, on_world_bounds: :stop]
      end

      it 'restricts moving' do
        expect { tick }.to change(
          velocity, :y
        ).to(0).and change(
          rectangle.position, :y
        ).to(90)
      end
    end
  end
end
