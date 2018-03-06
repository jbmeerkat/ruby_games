# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::Components::Base do
  describe '#new' do
    it { is_expected.to be }
    it { is_expected.to have_attributes id: a_value }
  end
end
