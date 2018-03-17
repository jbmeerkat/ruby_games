# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::World do
  subject(:hunger_value) { hunger_component.value }

  let(:hunger_component) do
    Class.new(ECS::Components::Base) do
      attribute :value, ECS::Components::Base::Types::Int

      def name
        :hunger
      end
    end[value: 5]
  end
  let(:feed_system) do
    Class.new(ECS::System) do
      watch_components :hunger
      run_on :update

      def process_entity(_, hunger)
        hunger.value -= 1
      end
    end.new
  end

  before do
    world = described_class.new(width: rand(10), height: rand(10))
    world.add_system(feed_system)

    cat = world.create_entity('cat')
    world.entity_registry.add_component(cat, hunger_component)

    5.times { world.update(time_delta: 1) }
  end

  it 'works' do
    expect(hunger_value).to eq 0
  end
end
