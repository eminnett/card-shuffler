##
# This class represents a single playing card. The card has a suit and a value.
# The card is either a face card or a pip card.

class Card
  SPADES      = :spades
  HEARTS      = :hearts
  DIAMONDS    = :diamonds
  CLUBS       = :clubs
  SUITS       = [SPADES, HEARTS, DIAMONDS, CLUBS]

  KING        = :king
  QUEEN       = :queen
  JACK        = :jack
  FACES       = [JACK, QUEEN, KING]
  FACE_VALUES = {JACK => 11, QUEEN => 12, KING => 13}
  VALUES      = (1..10).to_a + FACES

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

  # Returns a string representation of the card.
  def to_s
    value = @value == 1 ? "ace" : @value
    "the #{value} of #{suit}"
  end

  # Sorter to organise possible values given a comparison of both integers and symbols
  def self.value_sorter(x, y)
    x = FACES.include?(x) ? FACE_VALUES[x] : x
    y = FACES.include?(y) ? FACE_VALUES[y] : y
    x <=> y
  end

end