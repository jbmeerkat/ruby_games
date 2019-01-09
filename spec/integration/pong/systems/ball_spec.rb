# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Systems::Ball do
  let(:system) { described_class.new }
  let(:world) { ECS::World.new(width: 10, height: 10) }

  before do
    system.world = world
    ball = world.create_entity(:ball)

    world.entity_registry.add_component(ball, ball_velocity)
    world.entity_registry.add_component(
      ball,
      Pong::Components::Rectangle[position: ball_position, width: 5, height: 5]
    )

    left_racket = world.create_entity(:left_racket)
    world.entity_registry.add_component(
      left_racket,
      Pong::Components::Rectangle[
        position: Pong::Components::Position[x: 0, y: 0],
        width: 10,
        height: 10
      ]
    )

    right_racket = world.create_entity(:right_racket)
    world.entity_registry.add_component(
      right_racket,
      Pong::Components::Rectangle[
        position: Pong::Components::Position[x: 0, y: 100],
        width: 10,
        height: 10
      ]
    )
  end

  describe '#run' do
    context "when ball collides with world's lower bound" do
      let(:ball_velocity) { Pong::Components::Velocity[x: 0, y: 10] }
      let(:ball_position) { Pong::Components::Position[x: 0, y: world.height] }

      it 'ball bounces in opposite direction' do
        expect { system.run }.to change(
          ball_velocity, :y
        ).from(10).to(-10).and not_change(ball_velocity, :x)
      end
    end

    context "when ball collides with world's upper bound" do
      let(:ball_velocity) { Pong::Components::Velocity[x: 0, y: -10] }
      let(:ball_position) { Pong::Components::Position[x: 0, y: -5] }

      it 'ball bounces in opposite direction' do
        expect { system.run }.to change(
          ball_velocity, :y
        ).from(-10).to(10).and not_change(ball_velocity, :x)
      end
    end

    context 'when ball collides with racket' do
      let(:ball_velocity) { Pong::Components::Velocity[x: -10, y: 0] }
      let(:ball_position) { Pong::Components::Position[x: 5, y: 5] }

      it 'ball bounces in opposite direction' do
        expect { system.run }.to change(
          ball_velocity, :x
        ).from(-10).to(10).and not_change(ball_velocity, :y)
      end
    end
  end
end
