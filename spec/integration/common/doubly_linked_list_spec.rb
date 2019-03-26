# frozen_string_literal: true

require 'common_helper'
require 'common/doubly_linked_list'

RSpec.describe DoublyLinkedList do
  subject(:list) { described_class.new }

  describe '.from_array' do
    subject(:list) { described_class.from_array([1, 2, 3]) }

    it 'creates list from an array' do
      expect(list.head).to have_attributes(
        data: 1,
        next: have_attributes(
          data: 2,
          next: have_attributes(data: 3, next: nil)
        )
      )
    end
  end

  describe '#head' do
    before { list.add(1) }

    it "returns list's head" do
      expect(list.head).to have_attributes(data: 1, next: nil)
    end
  end

  describe '#add' do
    before do
      list.add(1)
      list.add(2)
    end

    it 'adds element to list' do
      expect(list.head).to have_attributes(
        data: 1,
        next: have_attributes(data: 2, next: nil, tail?: true),
        tail?: false
      )
    end
  end
end
