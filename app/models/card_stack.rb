##
# This class represents a generic collection of cards.

class CardStack < ActiveRecord::Base

  has_many :cards
  after_initialize :init

  def init
    @stack = []
  end

  # Inserts the given card to the top of the stack.
  def push(card)
    self.cards << card
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
  def split_at(index)

  end

  # Pushes the contents of the given stacks in the order they are given and
  def combine(stacks)

  end

  # The number of cards in the stack.
  def count

  end

  # Class method that pushes the contents of each of the given stacks onto the
  # first stack in the list. The first stack is then returned with the full
  # set of contents.
  def self.combine(stacks)

  end

end