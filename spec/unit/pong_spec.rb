# frozen_string_literal: true

require 'ostruct'

RSpec.describe Pong do
  before do
    allow_any_instance_of(Pong::Game).to receive(:config) do
      OpenStruct.new(described_class::DEFAULT_CONFIG)
    end
    allow_any_instance_of(Pong::MainWindow).to receive(:show)
  end

  it 'has version' do
    expect(described_class::VERSION).to be
  end

  it 'starts' do
    expect { described_class.start }.not_to raise_error
  end
end
