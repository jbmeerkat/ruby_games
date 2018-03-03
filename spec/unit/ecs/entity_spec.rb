# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::Entity do
  describe '#new_entity' do
    subject(:result) { described_class.create }

    it 'creates entity' do
      expect(result).to be
    end

    context 'when creating multiple' do
      subject(:entities) do
        Array.new(10) { described_class.create }
      end

      it 'creates unique entities' do
        expect(entities.uniq.count).to eq 10
      end
    end
  end
end
