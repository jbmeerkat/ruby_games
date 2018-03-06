# frozen_string_literal: true

require 'spec_helper'
require 'ecs/ext/dry/struct/mutable'

RSpec.describe Dry::Struct::Mutable do
  subject(:struct) { struct_class[foo: 'bar'] }

  let(:struct_class) do
    Class.new(Dry::Struct::Mutable) do
      attribute :foo, Dry::Types['string']
    end
  end

  describe 'setting value to attribute' do
    it 'changes attribute' do
      expect { struct.foo = 'baz' }.to change { struct.foo }
        .from('bar').to('baz')
    end
  end
end
