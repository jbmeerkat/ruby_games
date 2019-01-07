# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::World do
  let(:world) { described_class.new(width: rand(10), height: rand(10)) }

  describe '#update' do
    let(:test_system) do
      Class.new(ECS::System) do
        run_on :update
      end.new
    end

    before do
      allow(test_system).to receive(:run)

      world.add_system(test_system)

      world.update(time_delta: 5)
      world.update(time_delta: 5)
    end

    it 'runs all the update systems' do
      expect(test_system).to have_received(:run).twice
    end
  end

  describe '#draw' do
    let(:test_system) do
      Class.new(ECS::System) do
        run_on :draw
      end.new
    end

    before do
      allow(test_system).to receive(:run)

      world.add_system(test_system)

      world.time_delta = 0
      world.draw
    end

    it 'runs all the draw systems' do
      expect(test_system).to have_received(:run)
    end
  end
end
