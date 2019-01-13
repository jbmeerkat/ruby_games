# frozen_string_literal: true

require 'pong_helper'
require 'pong/components/score'

RSpec.describe Pong::Components::Score do
  subject(:score) { described_class[left: 2, right: 5] }

  it 'has right and left scores' do
    expect(score).to have_attributes left: 2, right: 5
  end

  describe '#add_left' do
    it 'increments left score' do
      expect { score.add_left }.to change(score, :left).from(2).to(3)
    end
  end

  describe '#add_right' do
    it 'increments right score' do
      expect { score.add_right }.to change(score, :right).from(5).to(6)
    end
  end
end
