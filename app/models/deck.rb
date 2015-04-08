##
# This class represents the classic deck of playing cards which is a specific
# type of CardStack with exactly 52 unique cards with 13 cards for each of
# the four suits.

class Deck < CardStack

  after_initialize :init

  def init

  end

end