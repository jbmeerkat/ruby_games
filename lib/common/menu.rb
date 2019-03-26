# frozen_string_literal: true

require 'common/linked_list'

# Simple menu implementation
#
# Only logic, without visualization
class Menu
  module Types
    include Dry::Types.module
  end

  class Item
    attr_reader :title, :selectable

    alias selectable? selectable

    def initialize(title:, selectable: true)
      @title = title
      @selectable = selectable
    end
  end

  attr_reader :selected_item

  def initialize(items)
    @items_list = LinkedList.from_array(items)
    @current_item = @items_list.head
    @selected_item = @current_item.data
  end

  def next
    return if tail?

    @current_item = next_selectable_item
    @selected_item = @current_item.data
  end

  def previous
  end

  private

  def next_item
    @current_item.next
  end

  def next_selectable_item
    item = next_item

    loop do
      break unless item
      break if item.data.selectable?

      item = item.next
    end

    item || @current_item
  end

  def tail?
    @current_item.tail?
  end
end
