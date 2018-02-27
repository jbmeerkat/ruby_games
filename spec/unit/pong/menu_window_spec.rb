# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::MenuWindow do
  let(:config) do
    double(window_height: 100, window_width: 100, window_caption: 'Foo')
  end
  let(:game) { double('Pong::Game', config: config, update: true, draw: true) }
  let(:expected_attributes) do
    { width: 100, height: 100, caption: 'Foo' }
  end

  subject(:window) { described_class.new(game: game) }

  before do
    def window.update
      close!
    end
  end

  it 'works', gosu: true do
    expect(window).to be
    expect(window).to have_attributes(expected_attributes)
    expect { window.show }.not_to raise_error
  end
end
