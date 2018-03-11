# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::MenuWindow do
  subject(:window) { described_class.new(game: game) }

  let(:config) do
    instance_double(
      'Pong::Config',
      window_height: 100,
      window_width: 100,
      window_caption: 'Foo'
    )
  end
  let(:game) do
    instance_double('Pong::Game', config: config, update: true, draw: true)
  end
  let(:expected_attributes) do
    { width: 100, height: 100, caption: 'Foo' }
  end

  before do
    def window.update
      close!
    end
  end

  it 'works', gosu: true do
    expect(window).to have_attributes(expected_attributes)
  end
end
