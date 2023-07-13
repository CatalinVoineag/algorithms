require 'byebug'

class Stack
  Node = Struct.new(:value, :prev)

  attr_accessor :length, :head, :tail

  def initialize
    self.head = self.tail
    self.length = 0
  end

  def push(value)
    node = Node.new(value: value)
    self.length += 1

    if self.head.nil?
      self.head = node
      return
    end

    node.prev = self.head
    self.head = node
  end

  def pop
    self.length = [0, self.length - 1].max

    if self.length == 0
      head = self.head
      self.head = nil
      return head&.value
    end

    head = self.head
    self.head = head.prev
    head.value
  end

  def peek
    self.head&.value
  end
end
