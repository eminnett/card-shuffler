require "rails_helper"

describe Shuffler, type: :service do
  before(:each) do
    @stack  = Deck.new
  end

  shared_examples_for "a shuffled stack" do
    it "should return a results hash" do
      expect(@result).to be_a(Hash)
    end

    it "should return a results hash with a shuffled_stack key" do
      expect(@result).to have_key(:shuffled_stack)
    end

    it "should result in a new ordering of the CardStack" do
      expect(@result[:shuffled_stack].to_s).not_to eq(@stack.to_s)
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
  end

  describe ".pile_shuffle" do
    before(:each) do
      @result = Shuffler.pile_shuffle @stack
    end

    it_behaves_like "a shuffled stack"

    it "should return a results hash with a piles_num key" do
      expect(@result).to have_key(:repeat_num)
    end
  end

  describe ".mongean_shuffle" do
    before(:each) do
      @result = Shuffler.mongean_shuffle @stack
    end

    it_behaves_like "a shuffled stack"
  end

  describe ".mexican_spiral_shuffle" do
    before(:each) do
      @result = Shuffler.mexican_spiral_shuffle @stack
    end

    it_behaves_like "a shuffled stack"
  end

  describe ".fisher_yates_shuffle" do
    before(:each) do
      @result = Shuffler.fisher_yates_shuffle @stack
    end

    it_behaves_like "a shuffled stack"
  end
end