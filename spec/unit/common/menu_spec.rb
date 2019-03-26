# frozen_string_literal: true

require 'common_helper'
require 'common/menu'

RSpec.describe Menu do
  subject(:menu) { described_class.new(items) }

  let(:items) do
    [
      Menu::Item.new(title: 'First'),
      Menu::Item.new(title: 'Second'),
      Menu::Item.new(title: 'Third')
    ]
  end

  describe '#next' do
    before do
      menu.next
    end

    it 'selects next item' do
      expect(menu.selected_item).to have_attributes(title: 'Second')
    end

    context 'when there is no next item' do
      let(:items) { [Menu::Item.new(title: 'First')] }

      it 'stays on the previously selected item' do
        expect(menu.selected_item).to have_attributes(title: 'First')
      end
    end

    context 'when next item is not selectable' do
      context 'when there is selectable item after disabled' do
        let(:items) do
          [
            Menu::Item.new(title: 'First'),
            Menu::Item.new(title: 'Second', selectable: false),
            Menu::Item.new(title: 'Third')
          ]
        end

        it 'skipping the disable and selects available' do
          expect(menu.selected_item).to have_attributes(title: 'Third')
        end
      end

      context 'when there are no further selectable items' do
        let(:items) do
          [
            Menu::Item.new(title: 'First'),
            Menu::Item.new(title: 'Second', selectable: false)
          ]
        end

        it 'stays on the previously selected item' do
          expect(menu.selected_item).to have_attributes(title: 'First')
        end
      end
    end
  end

  describe '#previous' do
    before { menu.previous }

    context 'when there is no previous item' do
      it 'stays on current item' do
        expect(menu.selected_item).to have_attributes(title: 'First')
      end
    end

    context 'when previous item is not selectable' do
      context 'when there is selectable item before disabled' do
      end

      context 'when there are no previous selectable items' do
      end
    end
  end
end
