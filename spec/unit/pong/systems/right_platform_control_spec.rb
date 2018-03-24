# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Systems::RightPlatformControl do
  describe '#process_entity' do
    let(:velocity) { Pong::Components::Velocity.new(x: 11, y: 22) }
    let(:right_platform) { double }
    let(:entity) { double }

    context 'when arrow down key is down' do
      before do
        allow(Gosu).to receive(:button_down?).with(Gosu::KB_DOWN).and_return(true)
      end

      it 'changes velocity on input' do
        expect {
          subject.process_entity(entity, right_platform, velocity)
        }.to change { velocity.y }.by(10)
      end
    end
  end
end

