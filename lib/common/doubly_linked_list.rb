# frozen_string_literal: true

class DoublyLinkedList
  class Node
    attr_reader :data
    attr_accessor :next, :previous

    def initialize(data:)
      @data = data
    end

    def add(node)
      if self.next
        self.next.add(node)
      else
        self.next = node
        node.previous = self
      end
    end

    def tail?
      self.next.nil?
    end
  end

  attr_reader :head

  def self.from_array(array)
    list = new
    array.each { |item| list.add(item) }

    list
  end

  def add(data)
    node = Node.new(data: data)

    if head
      head.add(node)
    else
      @head = node
    end

    head
  end
end
