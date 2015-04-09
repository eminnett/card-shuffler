require "rails_helper"

describe Shuffler, type: :service do
  before(:each) do
    @stack                = Deck.new
    @initial_count        = @stack.count
    @initial_stack_string = @stack.to_s
  end

  shared_examples_for "a shuffled stack" do
    it "should return a results hash" do
      expect(@result).to be_a(Hash)
    end

    it "should return a results hash with a shuffled_stack key" do
      expect(@result).to have_key(:shuffled_stack)
    end

    it "should result in a CardStack with a the same count" do
      expect(@result[:shuffled_stack].count).to equal(@initial_count)
    end

    it "should result in a CardStack with a different order" do
      expect(@result[:shuffled_stack].to_s).not_to eq(@initial_stack_string)
    end
  end

  describe ".shuffle" do
    before(:each) do
      @result = Shuffler.shuffle @stack
    end

    it_behaves_like "a shuffled stack"
  end

  describe ".cut" do
    before(:each) do
      @result = Shuffler.cut @stack
    end

    it_behaves_like "a shuffled stack"

    it "should return a results hash with a cut_index key" do
      expect(@result).to have_key(:cut_index)
    end
  end

  describe ".overhand_shuffle" do
    before(:each) do
      @result = Shuffler.overhand_shuffle @stack
    end

    it_behaves_like "a shuffled stack"

    it "should return a results hash with a repeat_num key" do
      expect(@result).to have_key(:repeat_num)
    end

    it "should return a results hash with a cuts_num key" do
      expect(@result).to have_key(:cuts_num)
    end
  end

  describe ".rifle_shuffle" do
    before(:each) do
      @result = Shuffler.rifle_shuffle @stack
    end

    it_behaves_like "a shuffled stack"

    it "should return a results hash with a repeat_num key" do
      expect(@result).to have_key(:repeat_num)
    end

    it "should return results ordered in the form of a Rifle shuffle" do
      cards = 6.times.map { Card.new }
      stack = CardStack.new cards
      stack = Shuffler.rifle_shuffle(stack)[:shuffled_stack]

      expected_order  = [3, 0, 4, 1, 5, 2]
      expected_string = "#{cards[expected_order.shift].to_s}"
      expected_order.each do |index|
        expected_string += ", #{cards[index].to_s}"
      end

      expect(stack.to_s).to eq(expected_string)
    end
  end

  describe ".pile_shuffle" do
    before(:each) do
      @result = Shuffler.pile_shuffle @stack
    end

    it_behaves_like "a shuffled stack"

    it "should return a results hash with a piles_num key" do
      expect(@result).to have_key(:piles_num)
    end

    it "should return results ordered by the dealt piles" do
      cards = 6.times.map { Card.new }
      stack = CardStack.new cards
      stack = Shuffler.pile_shuffle(stack, 2)[:shuffled_stack]

      expected_order  = [5, 3, 1, 4, 2, 0]
      expected_string = "#{cards[expected_order.shift].to_s}"
      expected_order.each do |index|
        expected_string += ", #{cards[index].to_s}"
      end

      expect(stack.to_s).to eq(expected_string)
    end
  end

  describe ".mongean_shuffle" do
    before(:each) do
      @result = Shuffler.mongean_shuffle @stack
    end

    it_behaves_like "a shuffled stack"

    it "should return results ordered in the form of a Mongean shuffle" do
      cards = 6.times.map { Card.new }
      stack = CardStack.new cards
      stack = Shuffler.mongean_shuffle(stack)[:shuffled_stack]

      expected_order  = [1, 3, 5, 4, 2, 0]
      expected_string = "#{cards[expected_order.shift].to_s}"
      expected_order.each do |index|
        expected_string += ", #{cards[index].to_s}"
      end

      expect(stack.to_s).to eq(expected_string)
    end
  end

  describe ".mexican_spiral_shuffle" do
    before(:each) do
      @result = Shuffler.mexican_spiral_shuffle @stack
    end

    it_behaves_like "a shuffled stack"

    it "should return results ordered in the form of a 'mexican spiral'" do
      cards = 6.times.map { Card.new }
      stack = CardStack.new cards
      stack = Shuffler.mexican_spiral_shuffle(stack)[:shuffled_stack]

      expected_order  = [5, 3, 1, 4, 0, 2]
      expected_string = "#{cards[expected_order.shift].to_s}"
      expected_order.each do |index|
        expected_string += ", #{cards[index].to_s}"
      end

      expect(stack.to_s).to eq(expected_string)
    end
  end

  describe ".fisher_yates_shuffle" do
    before(:each) do
      @result = Shuffler.fisher_yates_shuffle @stack
    end

    it_behaves_like "a shuffled stack"
  end
end