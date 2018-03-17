# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Components::Velocity do
  subject(:velocity) { described_class.new(x: x, y: y) }

  let(:x) { 10 }
  let(:y) { 10 }

  it 'has velocity values' do
    expect(velocity).to have_attributes x: 10, y: 10, max: nil
  end
end
