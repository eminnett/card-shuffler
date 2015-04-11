require "rails_helper"

describe Shuffler, type: :service do
  before(:each) do
    @deck                 = Deck.new
    @initial_count        = @deck.count
    @initial_stack_string = @deck.to_s
  end

  def six_card_test(expected_order, method, extra_params = [])
    cards = 6.times.map { Card.new }
    stack = CardStack.new cards
    stack = Shuffler.send(method, stack, *extra_params)[:shuffled_stack]

    expected_string = "#{cards[expected_order.shift].to_s}"
    expected_order.each do |index|
      expected_string += ", #{cards[index].to_s}"
    end

    return stack, expected_string
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

    it "should result in an empty CardStack when the input CardStack is empty" do
      empty_stack  = CardStack.new
      empty_result = Shuffler.send @method, empty_stack
      expect(empty_result[:shuffled_stack].count).to equal(0)
    end
  end

  describe ".shuffle" do
    before(:each) do
      @method = :shuffle
      @result = Shuffler.shuffle @deck
    end

    it_behaves_like "a shuffled stack"
  end

  describe ".cut" do
    before(:each) do
      @method = :cut
      @result = Shuffler.cut @deck
    end

    it_behaves_like "a shuffled stack"

    it "should return a results hash with a cut_index key" do
      expect(@result).to have_key(:cut_index)
    end
  end

  describe ".overhand_shuffle" do
    before(:each) do
      @method = :overhand_shuffle
      @result = Shuffler.overhand_shuffle @deck
    end

    it_behaves_like "a shuffled stack"

    it "should return a results hash with a repeat_num key" do
      expect(@result).to have_key(:repeat_num)
    end

    it "should return a results hash with a cuts_num key" do
      expect(@result).to have_key(:cuts_num)
    end

    it "should raise an error when there are as many cuts as cards" do
      deck = Deck.new
      expect { Shuffler.overhand_shuffle deck, deck.count }.to raise_error(RuntimeError)
    end

    it "should raise an error when there are more cuts than cards" do
      deck = Deck.new
      expect { Shuffler.overhand_shuffle deck, (deck.count + 1) }.to raise_error(RuntimeError)
    end

    it "should operate with a single cut" do
      deck        = Deck.new
      deck_string = deck.to_s
      result      = Shuffler.overhand_shuffle deck, 1

      expect(result[:shuffled_stack].to_s).not_to eq(deck_string)
    end

    it "should result in the Mongean shuffle when the number of cuts is one less than the number of cards" do
      deck            = Deck.new
      overhand_string = Shuffler.overhand_shuffle(deck, deck.count - 1)[:shuffled_stack].to_s
      deck            = Deck.new
      mongean_string  = Shuffler.mongean_shuffle(deck)[:shuffled_stack].to_s

      expect(overhand_string).to eq(mongean_string)
    end
  end

  describe ".rifle_shuffle" do
    before(:each) do
      @method = :rifle_shuffle
      @result = Shuffler.rifle_shuffle @deck
    end

    it_behaves_like "a shuffled stack"

    it "should return a results hash with a repeat_num key" do
      expect(@result).to have_key(:repeat_num)
    end

    it "should return results ordered in the form of a Rifle shuffle" do
      expected_order = [3, 0, 4, 1, 5, 2]
      stack, expected_string = six_card_test expected_order, :rifle_shuffle

      expect(stack.to_s).to eq(expected_string)
    end
  end

  describe ".pile_shuffle" do
    before(:each) do
      @method = :pile_shuffle
      @result = Shuffler.pile_shuffle @deck
    end

    it_behaves_like "a shuffled stack"

    it "should return a results hash with a piles_num key" do
      expect(@result).to have_key(:piles_num)
    end

    it "should return results ordered by the dealt piles" do
      expected_order = [5, 3, 1, 4, 2, 0]
      num_piles      = 2
      stack, expected_string = six_card_test expected_order, :pile_shuffle, [num_piles]

      expect(stack.to_s).to eq(expected_string)
    end
  end

  describe ".mongean_shuffle" do
    before(:each) do
      @method = :mongean_shuffle
      @result = Shuffler.mongean_shuffle @deck
    end

    it_behaves_like "a shuffled stack"

    it "should return results ordered in the form of a Mongean shuffle" do
      expected_order = [1, 3, 5, 4, 2, 0]
      stack, expected_string = six_card_test expected_order, :mongean_shuffle

      expect(stack.to_s).to eq(expected_string)
    end
  end

  describe ".mexican_spiral_shuffle" do
    before(:each) do
      @method = :mexican_spiral_shuffle
      @result = Shuffler.mexican_spiral_shuffle @deck
    end

    it_behaves_like "a shuffled stack"

    it "should return results ordered in the form of a 'mexican spiral'" do
      expected_order = [5, 3, 1, 4, 0, 2]
      stack, expected_string = six_card_test expected_order, :mexican_spiral_shuffle

      expect(stack.to_s).to eq(expected_string)
    end
  end

  describe ".fisher_yates_shuffle" do
    before(:each) do
      @method = :fisher_yates_shuffle
      @result = Shuffler.fisher_yates_shuffle @deck
    end

    it_behaves_like "a shuffled stack"
  end
end