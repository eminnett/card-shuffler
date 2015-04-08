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

  describe "#insert_at" do
    it "should error when inserting anything other than a Card" do
      stack = CardStack.new
      expect { stack.insert_at(0, "not a card") }.to raise_error(RuntimeError)
    end

    it "should error when inserting into an out of bounds index" do
      stack = CardStack.new
      expect { stack.insert_at(10, "not a card") }.to raise_error(RuntimeError)
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

  describe "#split_at!" do
    it "should return a new CardStack" do
      cards = 2.times.map { Card.new }
      stack = CardStack.new

      cards.each do |card|
        stack.push(card)
      end

      splitResult = stack.split_at! 1

      expect(pulled).to be_a(CardStack)
    end

    it "should update the CardStack" do
      cards = 2.times.map { Card.new }
      stack = CardStack.new

      cards.each do |card|
        stack.push(card)
      end

      stack.split_at! 1

      expect(stack.count).not.to equal(countAfterPush)
    end
  end

  describe "#count" do
    it "should be 0 by default" do
      expect(CardStack.new.count).to equal(0)
    end

    it "should increase by 1 after a push" do
      card         = Card.new
      stack        = CardStack.new
      initialCount = stack.count
      stack.push card

      expect(stack.count - initialCount).to equal(1)
    end

    it "should decrease by 1 after a pop" do
      card           = Card.new
      stack          = CardStack.new
      stack.push card
      countAfterPush = stack.count
      stack.pop

      expect(stack.count - countAfterPush).to equal(-1)
    end

    it "should increase by 1 after an insert_at" do
      card         = Card.new
      stack        = CardStack.new
      initialCount = stack.count
      stack.insert_at 0, card

      expect(stack.count - initialCount).to equal(1)
    end

    it "should decrease by 1 after a pull_from" do
      card           = Card.new
      stack          = CardStack.new
      stack.push card
      countAfterPush = stack.count
      stack.pull_from 0

      expect(stack.count - countAfterPush).to equal(-1)
    end
  end

  describe ".combine!" do
    it "should update the first CardStack" do
      numStacks        = 2
      numCardsPerStack = 2
      stacks = numStacks.times.map {
        cards = numCardsPerStack.times.map { Card.new }

        stack = CardStack.new

        cards.each do |card|
          stack.push(card)
        end

        stack
      }

      first_stack = stacks[0]
      count_before_combine = first_stack.count
      CardStack.combine! stacks
      expect(first_stack.count).not.to equal(count_before_combine)
    end

    it "should leave all but the first stack with 0 count" do
      numStacks        = 2
      numCardsPerStack = 2
      stacks = numStacks.times.map {
        cards = numCardsPerStack.times.map { Card.new }

        stack = CardStack.new

        cards.each do |card|
          stack.push(card)
        end

        stack
      }

      CardStack.combine! stacks
      expect(stacks[1].count).to equal(0)
    end
  end
end