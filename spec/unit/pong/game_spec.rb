# frozen_string_literal: true

require 'pong_helper'

RSpec.describe Pong::Game do
  subject(:game) { described_class.new(config: config) }

  let(:test_logger) do
    log_path = Pong.root.join('log', 'test.log')
    Logger.new(log_path, progname: 'pong_test')
  end
  let(:config) do
    messages = {
      window_width: 10,
      window_height: 10,
      window_caption: 'Foo',
      logger: test_logger
    }
    double('Pong::Config', messages)
  end

  before do
    allow(Pong::MenuWindow).to receive(:new) { double }
    allow(Pong::GameWindow).to receive(:new) { double }
  end

  describe 'play game' do
    before do
      allow(game).to receive(:show_menu) { nil }
    end

    it do
      expect(game).to have_state :inactive
      expect(game).to transition_from(:inactive).to(:menu).on_event(:start)
    end
  end
end
