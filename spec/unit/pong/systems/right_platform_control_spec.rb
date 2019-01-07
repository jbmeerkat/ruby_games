# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Systems::RightPlatformControl do
  describe '#process_entity' do
    subject(:system) { described_class.new }

    let(:velocity) { Pong::Components::Velocity.new(x: 0, y: 0) }
    let(:platform) { double }
    let(:entity) { double }

    before do
      system.world = ECS::World.new(height: 20, width: 20)
    end

    context 'when arrow down key is down' do
      before do
        allow(Gosu).to receive(:button_down?).with(Gosu::KB_DOWN)
          .and_return(true)
      end

      it 'changes velocity on input' do
        expect {
          system.process_entity(entity, platform, velocity)
        }.to change(velocity, :y).from(0).to(10)
      end
    end

    context 'when arrow up key is down' do
      before do
        allow(Gosu).to receive(:button_down?).with(Gosu::KB_DOWN)
          .and_return(false)
        allow(Gosu).to receive(:button_down?).with(Gosu::KB_UP)
          .and_return(true)
      end

      it 'changes velocity on input' do
        expect {
          system.process_entity(entity, platform, velocity)
        }.to change(velocity, :y).from(0).to(-10)
      end
    end
  end
end
