##
# This class represents a generic collection of cards.

class CardStack

  def initialize
    @stack = []
  end

  # Inserts the given card to the top of the stack.
  def push(card)

  end

  # Returns the top most card from the stack and removes it from the stack.
  def pop

  end

  # Inserts the given card at a specific point within the stack.
  def insert_at(index, card)

  end

  # Returns the at a specific point in the stack and removes it.
  def pull_from(index)

  end

  # Splits the
  def split_at!(index)

  end

  # The number of cards in the stack.
  def count

  end

  # Class method that pushes the contents of each of the given stacks onto the
  # first stack in the list. The first stack is updated with the full set of
  # contents and all the other stacks should be destroyed.
  def self.combine!(stacks)

  end

end