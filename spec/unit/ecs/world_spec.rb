# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::World do
  subject(:test_system) do
    Class.new(ECS::Systems::Base) do
      attr_accessor :elapsed, :times_called

      def initialize
        @elapsed = 0
        @times_called = 0
      end

      def process_tick(time_delta:)
        self.elapsed += time_delta
        self.times_called += 1
      end
    end.new
  end

  let(:world) { described_class.new }

  before do
    world.add_system(test_system)

    world.update(time_delta: 5)
    world.update(time_delta: 5)
  end

  it '#update' do
    expect(test_system).to have_attributes elapsed: 10, times_called: 2
  end
end
