# frozen_string_literal: true

require 'pong_helper'

require 'ostruct'

RSpec.describe Pong do
  before do
    allow(Pong::Game).to receive(:new) do
      instance_double('Pong::Game', start: true)
    end
  end

  it 'has version' do
    expect(described_class::VERSION).to be
  end

  it 'starts' do
    expect { described_class.start }.not_to raise_error
  end
end
