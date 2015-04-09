##
# This class represents the classic deck of playing cards which is a specific
# type of CardStack with exactly 52 unique cards with 13 cards for each of
# the four suits.

class Deck < CardStack

  def initialize
    super

    @basic_card_stack_class = CardStack

    suits  = Card::SUITS
    values = Card::VALUES
    suits.each do |suit|
      values.each do |value|
        push Card.new({:suit => suit, :value => value})
      end
    end
  end

end