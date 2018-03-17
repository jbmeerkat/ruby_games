# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::System do
  class Foo < ECS::Component
  end

  class Bar < ECS::Component
  end

  subject { system }

  let(:system) { Class.new(described_class).new }

  it { is_expected.to respond_to :run }

  describe '#entities_with' do
    subject(:result) do
      ->(bl) { system.entities_with(:foo, :bar, &bl) }
    end

    let(:entity_registry) { ECS::EntityRegistry.new }
    let(:entity) { entity_registry.create_entity }
    let(:foo_component) { Foo.new }
    let(:bar_component) { Bar.new }

    before do
      world = instance_double('ECS::World', entity_registry: entity_registry)
      system.world = world

      entity_registry.add_component(entity, foo_component)
      entity_registry.add_component(entity, bar_component)
    end

    it 'yields entity with components' do
      expect(result).to yield_with_args entity, foo_component, bar_component
    end
  end

  describe '#component' do
    subject(:result) { system.component(entity, component_name) }

    let(:entity_registry) { ECS::EntityRegistry.new }
    let(:entity) { entity_registry.create_entity }
    let(:component) { Foo.new }
    let(:component_name) { :foo }

    before do
      world = instance_double('ECS::World', entity_registry: entity_registry)
      system.world = world

      entity_registry.add_component(entity, component)
    end

    it 'returns proper component' do
      expect(result).to eq component
    end
  end

  describe '#time_delta' do
    subject(:time_delta) { system.time_delta }

    let(:entity_registry) { ECS::EntityRegistry.new }

    before do
      system.world = instance_double('ECS::World', time_delta: 100)
    end

    it 'returns time delta' do
      expect(time_delta).to eq 100
    end
  end
end
