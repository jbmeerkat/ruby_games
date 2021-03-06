# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Components::Rectangle do
  subject(:rectangle) do
    described_class[position: position, width: width, height: height]
  end

  let(:position) { Pong::Components::Position[x: 10, y: 10] }
  let(:width) { 100 }
  let(:height) { 100 }

  it 'has proper attributes' do
    expect(rectangle).to have_attributes x: 10, y: 10, width: 100, height: 100
  end
end
