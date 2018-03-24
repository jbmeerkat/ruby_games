# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::Component do
  class FooBar < described_class
  end

  subject { FooBar.new }

  describe '#new' do
    it { is_expected.to be }
    it { is_expected.to have_attributes id: a_value }
  end

  describe '#name' do
    it { is_expected.to have_attributes name: :foo_bar }
  end
end
