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
    result_stack = stack

    if stack.count > 0
      repeat_num.times do
        starting_stack = result_stack

        if cuts_num == starting_stack.count - 1
          result_stack      = CardStack.new [starting_stack.pop]
        else
          split_index_range = (cuts_num..starting_stack.count-1)
          result_stack      = starting_stack.split_at! rand(split_index_range)
        end


        if cuts_num > 1
          # Alternate between combining each cut at the top and the bottom

          num_iterations = cuts_num - 1
          num_iterations.times do |index|

            if index == num_iterations - 1
              # In this case, this is the last cut so simply add the remainder of starting_stack.
              stack_to_add = starting_stack
            elsif num_iterations - 1 - index == starting_stack.count - 1
              # In this case, we must add a stack containing only the top card in starting_stack.
              stack_to_add = CardStack.new [starting_stack.pop]
            else
              # Behave as normal by splutting randomly within the vaialble range.
              split_index_range = ((num_iterations - 1 - index)..(starting_stack.count - 1))
              stack_to_add = starting_stack.split_at!(rand(split_index_range))
            end

            stacks_to_combine = [result_stack, stack_to_add]
            stacks_to_combine.reverse if index.odd?

            result_stack = stacks_to_combine.first

            CardStack.combine! stacks_to_combine
          end
        else
          CardStack.combine! [result_stack, stack]
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

end