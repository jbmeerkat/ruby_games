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

  describe '#add_component' do
    let(:entity) { rand(100) }
    let(:component) { double('ECS::Components::Base') }

    subject(:add_component) { registry.add_component(entity, component) }
    subject(:entity_components) { registry.entity_components }
    subject(:component_entities) { registry.component_entities }

    it 'adds component' do
      expect {
        add_component
      }.to change {
        entity_components[entity].count
      }.by(1).and change {
        component_entities[component].count
      }.by(1)

      expect(entity_components[entity]).to include component
      expect(component_entities[component]).to include entity
    end
  end
end
