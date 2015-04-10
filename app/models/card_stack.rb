##
# This class represents a generic collection of cards.

class CardStack

  def initialize(cards = [])
    @stack = []
    cards.each do |card|
      error_unless_param_is_a_card card, "include"
      @stack.push card
    end
  end

  # Inserts the given card to the top of the stack.
  def push(card)
    error_unless_param_is_a_card card, "push"
    @stack.push(card)
  end

  # Returns the top most card from the stack and removes it from the stack.
  def pop
    @stack.pop
  end

  # Inserts the given card at a specific point within the stack. Negative indices
  # indicate a distance from the top rather than the bottom.
  def insert(index, card)
    error_unless_param_is_a_card card, "insert"
    error_unless_index_is_in_bounds index unless index == count

    @stack.insert index, card
  end

  # Returns the Card at a specific point in the stack and removes it.
  def pull_from(index)
    error_unless_index_is_in_bounds index

    card = @stack[index]
    @stack.delete_at index
    card
  end

  # Swaps the cards at the two given indices.
  def swap!(i, j)
    return if i == j

    error_unless_index_is_in_bounds i
    error_unless_index_is_in_bounds j

    @stack[i], @stack[j] = @stack[j], @stack[i]
  end

  # Splits the CardStack at the given index returning a new CardStack
  # comprised of the "top" and leaving the "bottom".
  def split_at!(index)
    remainder = @stack.from(index)
    @stack    = @stack[0...index]

    self.class.new remainder
  end

  # The number of cards in the stack.
  def count
    @stack.count
  end

  # Returns a string representation of the CardStack.
  def to_s
    s = ""
    @stack.each do |card|
      s += ", " if s.length > 0
      s += card.to_s
    end
    s
  end

  # Class method that pushes the contents of each of the given stacks onto the
  # first stack in the list. The first stack is updated with the full set of
  # contents.
  def self.combine!(stacks)
    first_stack  = stacks.shift
    second_stack = stacks[0]

    # If we have more than one stack left, we want to combine what is left.
    self.combine! stacks unless stacks.count == 1

    while second_stack.count > 0
      first_stack.push second_stack.pull_from 0
    end
  end

  private

    def error_unless_param_is_a_card(param, verb)
      raise "CardStacks can only #{verb} Cards" unless param.is_a? Card
    end

    def error_unless_index_is_in_bounds(i)
      raise "#{i} is an out of bounds index for this CardStack" if index_out_of_bounds? i
    end

    # Is the supplied index either non-zero and the stack is empty or is the
    # index outside of the range of positive and negative value bounded by count - 1?
    def index_out_of_bounds?(index)
      return false if index == 0
      count == 0 || !(-(count - 1)..(count - 1)).include?(index)
    end

end