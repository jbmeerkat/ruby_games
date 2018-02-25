# frozen_string_literal: true

RSpec.describe Pong::Game do
  let(:config) { double('Pong::Config', logger: nil) }

  subject(:game) { described_class.new(config: config) }

  describe 'initial state' do
    it { expect(game).to have_state :menu }
  end

  describe 'play game' do
    it { expect(game).to transition_from(:menu).to(:playing).on_event(:play) }
  end
end
