# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::World do
  let(:test_system) do
    Class.new(ECS::System) do
      run_on :update
    end.new
  end

  let(:world) { described_class.new(width: rand(10), height: rand(10)) }

  before do
    allow(test_system).to receive(:run)

    world.add_system(test_system)

    world.update(time_delta: 5)
    world.update(time_delta: 5)
  end

  it '#update' do
    expect(test_system).to have_received(:run).twice
  end
end
