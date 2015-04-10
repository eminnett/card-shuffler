require "rails_helper"

describe CardStack, type: :model do

  describe "#push" do
    it "should error when pushing anything other than a Card" do
      stack = CardStack.new
      expect { stack.push("not a card") }.to raise_error(RuntimeError)
    end
  end

  describe "#pop" do
    it "should return a card" do
      card   = Card.new
      stack  = CardStack.new
      stack.push card
      popped = stack.pop

      expect(popped).to be_a(Card)
    end
  end

  describe "#insert" do
    it "should error when inserting anything other than a Card" do
      stack = CardStack.new
      expect { stack.insert(0, "not a card") }.to raise_error(RuntimeError)
    end

    it "should error when inserting into an out of bounds index" do
      stack = CardStack.new
      expect { stack.insert(10, "not a card") }.to raise_error(RuntimeError)
    end
  end

  describe "#pull_from" do
    it "should return a card" do
      card   = Card.new
      stack  = CardStack.new
      stack.push(card)
      pulled = stack.pull_from 0

      expect(pulled).to be_a(Card)
    end

    it "should error when pulling from an out of bounds index" do
      stack = CardStack.new
      expect { stack.pull_from(10) }.to raise_error(RuntimeError)
    end
  end

  describe "#swap!" do
    it "should do nothing when the indices are the same" do
      cards = 2.times.map { Card.new }
      stack = CardStack.new cards
      initial_stack_as_string = stack.to_s

      stack.swap! 0, 0

      expect(stack.to_s).to eq(initial_stack_as_string)
    end

    it "should swap the cards at the given indices" do
      cards = 2.times.map { Card.new }
      stack = CardStack.new cards

      stack.swap! 0, 1

      expect(stack.to_s).to eq("#{cards[1].to_s}, #{cards[0].to_s}")
    end

    it "should maintain the count" do
      cards         = 2.times.map { Card.new }
      stack         = CardStack.new cards
      initial_count = stack.count

      stack.swap! 0, 1

      expect(stack.count).to equal(initial_count)
    end

    it "should error when swapping an out of bounds index" do
      cards = 2.times.map { Card.new }
      stack = CardStack.new cards
      expect { stack.swap! 0, 2 }.to raise_error(RuntimeError)
    end
  end

  describe "#split_at!" do
    it "should return a new CardStack" do
      cards        = 2.times.map { Card.new }
      stack        = CardStack.new cards
      split_result = stack.split_at! 1

      expect(split_result).to be_a(CardStack)
    end

    it "should update the CardStack" do
      cards            = 2.times.map { Card.new }
      stack            = CardStack.new cards
      count_after_push = stack.count

      stack.split_at! 1

      expect(stack.count).not_to equal(count_after_push)
    end
  end

  describe "#count" do
    it "should be 0 by default" do
      expect(CardStack.new.count).to equal(0)
    end

    it "should increase by 1 after a push" do
      card          = Card.new
      stack         = CardStack.new
      initial_count = stack.count
      stack.push card

      expect(stack.count - initial_count).to equal(1)
    end

    it "should decrease by 1 after a pop" do
      card             = Card.new
      stack            = CardStack.new
      stack.push card
      count_after_push = stack.count
      stack.pop

      expect(stack.count - count_after_push).to equal(-1)
    end

    it "should incr ease by 1 after an insert" do
      card          = Card.new
      stack         = CardStack.new
      initial_count = stack.count
      stack.insert 0, card

      expect(stack.count - initial_count).to equal(1)
    end

    it "should decrease by 1 after a pull_from" do
      card             = Card.new
      stack            = CardStack.new
      stack.push card
      count_after_push = stack.count
      stack.pull_from 0

      expect(stack.count - count_after_push).to equal(-1)
    end
  end

  describe "#to_s" do
    it "should return a comma seperated string of all the card strings" do
      cards = 2.times.map { Card.new }
      stack = CardStack.new cards

      expect(stack.to_s).to eq("#{cards[0].to_s}, #{cards[1].to_s}")
    end
  end

  describe ".combine!" do
    it "should update the first CardStack" do
      num_stacks          = 2
      num_cards_per_stack = 2
      stacks = num_stacks.times.map {
        cards = num_cards_per_stack.times.map { Card.new }
        CardStack.new cards
      }

      first_stack = stacks[0]
      count_before_combine = first_stack.count
      CardStack.combine! stacks
      expect(first_stack.count).not_to equal(count_before_combine)
    end

    it "should leave all but the first stack with 0 count" do
      num_stacks          = 2
      num_cards_per_stack = 2
      stacks = num_stacks.times.map {
        cards = num_cards_per_stack.times.map { Card.new }
        CardStack.new cards
      }

      second_stack = stacks[1]

      CardStack.combine! stacks
      expect(second_stack.count).to equal(0)
    end

    it "should combine more than two stacks" do
      num_stacks          = 5
      num_cards_per_stack = 2
      stacks = num_stacks.times.map {
        cards = num_cards_per_stack.times.map { Card.new }
        CardStack.new cards
      }

      first_stack = stacks[0]
      CardStack.combine! stacks

      expect(first_stack.count).to equal(num_stacks * num_cards_per_stack)
    end
  end
end