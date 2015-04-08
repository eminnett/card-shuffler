##
# This class represents a single playing card. The card has a suit and a value.
# The card is either a face card or a pip card.

class Card
  SPADES   = :spades
  HEARTS   = :hearts
  DIAMONDS = :diamonds
  CLUBS    = :clubs
  SUITS    = [SPADES, HEARTS, DIAMONDS, CLUBS]

  KING     = :king
  QUEEN    = :queen
  JACK     = :jack
  FACES    = [JACK, QUEEN, KING]
  VALUES   = (1..10).to_a + FACES

  attr_reader :suit, :value

  def initialize(params = {})

  end

  # Is this a face card?
  def face_card?

  end

  # Is this a pip card?
  def pip_card?

  end

end