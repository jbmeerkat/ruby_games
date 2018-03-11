# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::EntityRegistry do
  let(:registry) { described_class.new }

  describe '#create_entity' do
    subject(:create_entity) { registry.create_entity }

    it 'creates new entity' do
      expect { create_entity }.to change { registry.entities.count }.by 1
    end

    context 'when tagged' do
      subject(:create_entity) { registry.create_entity(:cat) }

      it 'created tagged entity' do
        expect { create_entity }.to change {
          registry.entities_by_tag[:cat].count
        }.by 1
      end
    end
  end

  # rubocop:disable all
  describe '#add_component' do
    subject(:entity_components) { registry.entity_components }
    subject(:component_entities) { registry.component_entities }

    let(:entity) { rand(100) }
    let(:component) { instance_double('ECS::Components::Base', name: :foo) }

    it 'adds component' do
      expect {
        registry.add_component(entity, component)
      }.to change {
        entity_components[entity].count
      }.by(1).and change {
        component_entities[:foo].count
      }.by(1)

      expect(entity_components[entity]).to include component
      expect(component_entities[:foo]).to include entity
    end
  end
  # rubocop:enable

  describe '#with_components' do
    def create_component(name)
      instance_double('ECS::Components::Base', name: name)
    end

    subject(:entities) do
      registry.with_components(foo_component.name, bar_component.name)
    end

    let(:entity1) { 1 }
    let(:entity2) { 2 }
    let(:foo_component) { create_component(:foo) }
    let(:bar_component) { create_component(:bar) }
    let(:baz_component) { create_component(:baz) }
    let(:expected_entities) { [entity1, entity2] }

    before do
      registry.add_component(entity1, foo_component)
      registry.add_component(entity1, bar_component)
      registry.add_component(entity2, foo_component)
      registry.add_component(entity2, bar_component)

      # control group
      registry.add_component(111, foo_component)
      registry.add_component(1, baz_component)
    end

    it 'returns proper entities' do
      expect(entities).to contain_exactly(*expected_entities)
    end
  end

  describe '#entity_component' do
    subject(:entity_component) do
      registry.entity_component(entity, component.name)
    end

    let(:entity) { 1 }
    let(:component) { instance_double('ECS::Components::Base', name: :foo) }
    let(:expected_component) { component }

    before { registry.add_component(entity, component) }

    it 'returns entity component' do
      expect(entity_component).to eq expected_component
    end
  end
end
