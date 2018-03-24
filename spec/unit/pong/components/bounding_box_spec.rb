# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Components::BoundingBox do
  subject(:box) { described_class[rectangle: rectangle] }

  let(:rectangle) do
    Pong::Components::Rectangle[
      position: Pong::Components::Position[x: 10, y: 20],
      width: 20,
      height: 10
    ]
  end

  it 'has correct left top coord' do
    expect(box.left_top).to eq Point[x: 10, y: 20]
  end

  it 'has correct right top coord' do
    expect(box.right_top).to eq Point[x: 30, y: 20]
  end

  it 'has correct right bottom coord' do
    expect(box.right_bottom).to eq Point[x: 30, y: 30]
  end

  it 'has correct left bottom coord' do
    expect(box.left_bottom).to eq Point[x: 10, y: 30]
  end
end
