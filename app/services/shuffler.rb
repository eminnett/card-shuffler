##
# This class encapsulates the various methods of shuffling cards and requisite
# logic associated with those methods. The various methods present were heavily
# inspired by the Wikipedia page on shuffling cards (http://en.wikipedia.org/wiki/Shuffling).

class Shuffler

  def self.shuffle(stack)
    self.fisher_yates_shuffle stack
  end

  #
  def self.cut(stack, cut_index = nil)

  end

  #
  def self.overhand_shuffle(stack, repeat_num = 1, cuts_num = 1)

  end

  #
  def self.rifle_shuffle(stack)

  end

  #
  def self.pile_shuffle(stack, piles_num = 2)

  end

  #
  def self.mongean_shuffle(stack)

  end

  #
  def self.mexican_spiral_shuffle(stack)

  end

  #
  def self.fisher_yates_shuffle(stack)

  end

end