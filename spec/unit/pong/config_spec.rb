# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Config do
  subject(:result) { described_class.new(params) }

  context 'when valid data' do
    let(:params) do
      { window_width: 100, window_height: 100 }
    end
    let(:expected_attributes) do
      { window_width: 100, window_height: 100, window_caption: 'Pong' }
    end

    it 'constructs config' do
      expect(result).to have_attributes expected_attributes
    end
  end

  context 'when invalid data' do
    let(:params) do
      { unexpected_param: 'foo' }
    end

    it 'fails' do
      expect { result }.to raise_error Dry::Struct::Error
    end
  end
end
