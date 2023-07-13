require 'byebug'

class QueueClass
  Node = Struct.new(:value, :next)

  attr_accessor :length, :head, :tail

  def initialize
    self.head = self.tail
    self.length = 0
  end

  def enqueue(value)
    node = Node.new(value: value)
    self.length += 1

    if self.tail.nil?
      self.tail = self.head = node
      return
    end

    self.tail.next = node
    self.tail = node
  end

  def deque
    if self.head.nil?
      return nil
    end

    self.length -= 1

    current_head = head
    self.head = self.head.next

    if self.length == 0
      self.tail = nil
    end

    current_head.value
  end

  def peek
    self.head&.value
  end
end
