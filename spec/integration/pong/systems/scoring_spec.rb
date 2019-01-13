# frozen_string_literal: true

require 'pong_helper'
require 'pong/systems/scoring'

RSpec.describe Pong::Systems::Scoring do
  let(:system) { described_class.new }
  let(:score) { Pong::Components::Score.new }

  before do
    world = ECS::World.new(width: 100, height: 100)
    system.world = world

    ball = world.create_entity(:ball)
    rectangle = Pong::Components::Rectangle[
      position: Pong::Components::Position[x: ball_x, y: 0],
      width: 10,
      height: 10
    ]

    score_entity = world.create_entity(:score)

    world.entity_registry.add_component(ball, rectangle)
    world.entity_registry.add_component(score_entity, score)
  end

  context "when left world's bound was hit" do
    let(:ball_x) { -1 }

    it 'adds score to the right player' do
      expect { system.run }.to change(score, :right).by(1)
        .and not_change(score, :left)
    end
  end

  context "when right world's bound was hit" do
    let(:ball_x) { 91 }

    it 'adds score to the left player' do
      expect { system.run }.to change(score, :left).by(1)
        .and not_change(score, :right)
    end
  end
end
