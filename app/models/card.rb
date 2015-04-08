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
    @value = params.has_key?(:value) ? params[:value] : VALUES.sample
    @suit  = params.has_key?(:suit)  ? params[:suit]  : SUITS.sample

    raise "Instances of Card must have a value in #{VALUES.to_s}" unless VALUES.include? @value
    raise "Instances of Card must have a suit in #{SUITS.to_s}"   unless SUITS.include?  @suit
  end

  # Is this a face card?
  def face_card?
    FACES.include? @value
  end

  # Is this a pip card?
  def pip_card?
    !face_card?
  end

end