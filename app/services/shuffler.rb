##
# This class encapsulates the various methods of shuffling cards and requisite
# logic associated with those methods. The various methods present were heavily
# inspired by the Wikipedia page on shuffling cards (http://en.wikipedia.org/wiki/Shuffling).

class Shuffler

  def self.shuffle(stack)
    self.fisher_yates_shuffle stack
  end

  # Simulates cutting a given CardStack at a given index.
  def self.cut(stack, cut_index = nil)

  end

  # Simulates the overhand shuffle technique with a given number of repetitions
  # each with a given number of cuts.
  def self.overhand_shuffle(stack, repeat_num = 1, cuts_num = 1)

  end

  # Simulates the rifle shuffle technique with a given number of repetitions.
  # The rifle shuffle should interleave the Cards from a cut CardStack.
  def self.rifle_shuffle(stack, repeat_num = 1)

  end

  # Simulates the pile shuffle technique with a given number of piles.
  # This technique effectively "deals" the cards into a number of piles
  # and then combines the piles back into a single CardStack.
  def self.pile_shuffle(stack, piles_num = 2)

  end

  # Simulates the Mongean shuffle technique. This technique is effectively
  # an Overhand Shuffle where the number of cuts is the CardStack.count - 1
  # resulting in each cut consisting of a single card.
  def self.mongean_shuffle(stack)

  end

  # Simulates the Mexican Spiral shuffle technique. This technique alternates
  # between "dealing" the top Card into a single pile and placing the top Card
  # at the bottom of the CardStack.
  def self.mexican_spiral_shuffle(stack)

  end

  # Shuffles the CardStack using the Fisher-Yates (AKA Knuth) algorithm.
  # This will result in a randomisation of the CardStack which is as
  # "perfect" as the random number generator used.
  # See http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle for more info.
  def self.fisher_yates_shuffle(stack)

  end

end