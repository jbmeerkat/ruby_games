# frozen_string_literal: true

require 'common_helper'
require 'common/stopwatch'

RSpec.describe Stopwatch do
  subject(:stopwatch) { described_class.new(clock: clock) }

  let(:clock) { double }

  before do
    allow(clock).to receive(:milliseconds).and_return(1000, 1200, 1400)

    stopwatch.start
  end

  describe '#start' do
    it 'saves last clock time' do
      expect(stopwatch.last_clock_time).to eq 1000
    end
  end

  describe '#lap' do
    it 'tracks delta from previous lap' do
      expect(stopwatch.lap).to eq(200)
    end

    it 'saves last clock time' do
      expect {
        stopwatch.lap
      }.to change(stopwatch, :last_clock_time).from(1000).to(1200)
    end
  end

  describe '#pause' do
    context 'when pausing started' do
      it 'stops counting time' do
        stopwatch.pause

        expect(stopwatch.lap).to eq 0
      end
    end

    context 'when starting paused' do
      before { stopwatch.pause }

      it 'starts counting time' do
        stopwatch.start

        expect(stopwatch.lap).to eq 200
      end
    end
  end
end
