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

    if stack.count == 0
      result_stack = stack
    else
      cut_index  ||= rand (1..(stack.count - 1))
      result_stack = stack.split_at! cut_index
      CardStack.combine! [result_stack, stack]
    end
    {:shuffled_stack => result_stack, :cut_index => cut_index}
  end

  # Simulates the overhand shuffle technique with a given number of repetitions
  # each with a given number of cuts.
  def self.overhand_shuffle(stack, cuts_num = 5, repeat_num = 1)
    if stack.count > 0 && cuts_num >= stack.count
      raise "Overhand shuffle must use fewer cuts than cards unless there are no cards to shuffle."
    end

    result_stack = stack

    if stack.count > 0
      repeat_num.times do
        starting_stack = result_stack

        # Setup the initial stack for the shuffle.
        result_stack   = self.overhand_first_cut starting_stack, cuts_num

        cuts_num -= 1

        if cuts_num == 0
          # If the first cut is the only cut, simply combine the result with the starting_stack.
          CardStack.combine! [result_stack, starting_stack]
        else
          # Alternate between combining each cut at the top and the bottom
          (0..cuts_num).to_a.each do |index|
            remaining_cuts     = cuts_num - index
            combine_from_below = index.odd?
            result_stack = self.overhand_subsequent_cut result_stack, starting_stack, remaining_cuts, combine_from_below
          end
        end
      end
    end

    {:shuffled_stack => result_stack, :cuts_num => cuts_num, :repeat_num => repeat_num}
  end

  # Simulates the rifle shuffle technique with a given number of repetitions.
  # The rifle shuffle should interleave the Cards from a cut CardStack.
  def self.rifle_shuffle(stack, repeat_num = 1)
    result_stack = stack

    if stack.count > 0
      repeat_num.times do
        # We take the ceiling of count / 2 as we want split_stack
        # to be of equal sie or smaller than that of result_stack.
        split_stack = result_stack.split_at! (result_stack.count / 2 ).ceil

        # Interleave the contents of split_stack with that of result_stack from
        # the bottom. This keep indexing consistent.
        (0...split_stack.count).each do |i|
          result_stack.insert (i * 2), split_stack.pull_from(0)
        end
      end
    end

    {:shuffled_stack => result_stack, :repeat_num => repeat_num}
  end

  # Simulates the pile shuffle technique with a given number of piles.
  # This technique effectively "deals" the cards into a number of piles
  # and then combines the piles back into a single CardStack.
  def self.pile_shuffle(stack, piles_num = 5)

    dealt_stacks = piles_num.times.map {CardStack.new}
    while stack.count > 0 do
      (0...piles_num).each do |i|
        dealt_stacks[i].push stack.pop
        break if stack.count == 0
      end
    end

    # We assume the piles are dealt from left to right which suggests the
    # first pile is at the bottom when combined from right to left.
    result_stack = dealt_stacks[0]

    CardStack.combine! dealt_stacks

    {:shuffled_stack => result_stack, :piles_num => piles_num}
  end

  # Simulates the Mongean shuffle technique. This technique starts with
  # the top card and then places each additional into the new stack
  # alternating between the top and the bottom.
  def self.mongean_shuffle(stack)
    result_stack = stack

    if stack.count > 0
      result_stack = CardStack.new [stack.pop]
      (0...stack.count).each do |index|
        top_card = stack.pop
        if index.even?
          result_stack.push top_card
        else
          result_stack.insert 0, top_card
        end
      end
    end

    {:shuffled_stack => result_stack}
  end

  # Simulates the Mexican Spiral shuffle technique. This technique alternates
  # between "dealing" the top Card into a single pile and placing the top Card
  # at the bottom of the CardStack.
  def self.mexican_spiral_shuffle(stack)

    if stack.count == 0
      result_stack = stack
    else
      result_stack = CardStack.new [stack.pop]
      while stack.count > 0 do
        top_card = stack.pop
        stack.insert 0, top_card
        result_stack.push stack.pop
      end
    end

    {:shuffled_stack => result_stack}
  end

  # Shuffles the CardStack using the Fisher-Yates (AKA Knuth) algorithm.
  # This will result in a randomisation of the CardStack which is as
  # "perfect" as the random number generator used.
  # See http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle for more info.
  def self.fisher_yates_shuffle(stack)

    stack = stack
    (0..(stack.count-1)).each do |i|
      index_to_swap = rand(0..i)
      stack.swap! i, index_to_swap
    end

    {:shuffled_stack => stack}
  end

  private

  # Returns the result of the first cut for the overhand shuffle.
  def self.overhand_first_cut stack, cuts_num
    possible_cuts = stack.count - 1
    if cuts_num == possible_cuts
      CardStack.new [stack.pop]
    else
      stack.split_at! rand((cuts_num..possible_cuts))
    end
  end

  # Handles a single cut for the overhand shuffle and returns the combination
  # of this cut and the stack the cut is added to.
  def self.overhand_subsequent_cut shuffle_to_stack, shuffle_from_stack, remaining_cuts, combine_from_below

    possible_cuts = shuffle_from_stack.count - 1

    if remaining_cuts == 0
      # In this case, this is the last cut so simply add the remainder of starting_stack.
      stack_to_add      = shuffle_from_stack
    elsif remaining_cuts == possible_cuts
      # In this case, we must add a stack containing only the top card in starting_stack.
      stack_to_add      = CardStack.new [shuffle_from_stack.pop]
    else
      # Behave as normal by splitting randomly within the viable range.
      split_index_range = (remaining_cuts..possible_cuts)
      stack_to_add      = shuffle_from_stack.split_at!(rand(split_index_range))
    end

    stacks_to_combine = [shuffle_to_stack, stack_to_add]
    stacks_to_combine.reverse! if combine_from_below

    result_stack      = stacks_to_combine.first

    CardStack.combine! stacks_to_combine

    result_stack
  end

end