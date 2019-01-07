# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Systems::Ball do
  let(:system) { described_class.new }

  before do
    world = ECS::World.new(width: 10, height: 10)
    system.world = world
    ball = world.create_entity(:ball)

    world.entity_registry.add_component(ball, velocity)

    world.entity_registry.add_component(
      ball,
      Pong::Components::Rectangle[position: position, width: 10, height: 10]
    )
  end

  describe '#run' do
    context "when ball collides with world's lower bound" do
      let(:velocity) { Pong::Components::Velocity[x: 0, y: 10] }
      let(:position) { Pong::Components::Position[x: 0, y: 5] }

      it 'ball bounces in opposite direction' do
        expect { system.run }.to change(
          velocity, :y
        ).from(10).to(-10).and not_change(velocity, :x)
      end
    end

    context "when ball collides with world's upper bound" do
      let(:velocity) { Pong::Components::Velocity[x: 0, y: -10] }
      let(:position) { Pong::Components::Position[x: 0, y: -5] }

      it 'ball bounces in opposite direction' do
        expect { system.run }.to change(
          velocity, :y
        ).from(-10).to(10).and not_change(velocity, :x)
      end
    end
  end
end
