# frozen_string_literal: true

RSpec.describe Pong::Game do
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

  subject(:game) { described_class.new(config: config) }

  before do
    allow(Pong::MenuWindow).to receive(:new) { double }
    allow(Pong::GameWindow).to receive(:new) { double }
  end

  describe 'initial state' do
    it { expect(game).to have_state :inactive }
  end

  describe 'play game' do
    before do
      allow(game).to receive(:show_menu) { nil }
    end

    it { expect(game).to transition_from(:inactive).to(:menu).on_event(:start) }
  end
end
