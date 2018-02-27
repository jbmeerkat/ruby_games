# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::Component do
  describe '#new' do
    subject { described_class.new }

    it { is_expected.to be }
  end
end
