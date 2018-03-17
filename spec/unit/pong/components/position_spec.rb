# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Components::Position do
  subject(:position) { described_class.new(x: x, y: y) }

  let(:x) { 10 }
  let(:y) { 10 }

  it 'has coordinates' do
    expect(position).to have_attributes x: 10, y: 10
  end
end
