# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::EntityRegistry do
  describe '#new_entity' do
    subject(:result) { described_class.new.create_entity }

    it 'creates entity' do
      expect(result).to be
    end
  end

  describe '#add_component' do
    let(:registry) { described_class.new }
    let(:entity) { registry.create_entity(tag: 'test') }
    let(:component) { double('ECS::Component') }
    let(:expected_components) { [component] }

    subject(:components) { registry.entity_components(entity) }

    before do
      registry.add_component(entity, component)
    end

    it 'adds component' do
      expect(components).to eq expected_components
    end
  end

  describe '#entity_components' do
    xit 'returns correct components' do
    end
  end

  describe '#entities_with_component' do
    xit 'returns correct entities' do
    end
  end
end
