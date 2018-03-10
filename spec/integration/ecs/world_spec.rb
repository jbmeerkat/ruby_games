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
    Class.new(ECS::Systems::Base) do
      def process_tick(_)
        entities_with(:hunger) do |_, hunger|
          hunger.value -= 1
        end
      end
    end.new
  end

  before do
    world = described_class.new
    world.add_system(feed_system)

    cat = world.create_entity('cat')
    world.entity_registry.add_component(cat, hunger_component)

    5.times { world.update(time_delta: 1) }
  end

  it 'works' do
    expect(hunger_value).to eq 0
  end
end
