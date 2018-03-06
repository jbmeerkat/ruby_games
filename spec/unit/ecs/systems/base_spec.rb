# frozen_string_literal: true

require 'ecs_helper'

RSpec.describe ECS::Systems::Base do
  subject { described_class.new(entities_registry: nil) }

  it { is_expected.to respond_to :run }
end
