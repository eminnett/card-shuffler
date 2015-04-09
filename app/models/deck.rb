##
# This class represents the classic deck of playing cards which is a specific
# type of CardStack with exactly 52 unique cards with 13 cards for each of
# the four suits.

class Deck < CardStack

  def initialize
    super

    suits  = Card::SUITS
    values = Card::VALUES
    suits.each do |suit|
      values.each do |value|
        push Card.new({:suit => suit, :value => value})
      end
    end
  end

  def split_at!(index)
    remainder = @stack.from(index)
    @stack    = @stack[0...index]

    # This needs to be a CardStack and not a Deck.
    CardStack.new remainder
  end

end