# frozen_string_literal: true

class LinkedList
  class Node
    attr_reader :data
    attr_accessor :next

    def initialize(data:, next_node: nil)
      @data = data
      @next_node = next_node
    end

    def add(node)
      self.next ? self.next.add(node) : self.next = node
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
