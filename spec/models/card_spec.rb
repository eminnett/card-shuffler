require "rails_helper"

describe Card, type: :model do
  it "should have an acceptable value by default" do
    expect(Card::VALUES).to include(Card.new.value)
  end

  it "should have an acceptable suit by default" do
    expect(Card::SUITS).to include(Card.new.suit)
  end

  it "should treat a value greater than 10 as a face card" do
    expect(Card.new({:value => 12}).value).to equal(Card::QUEEN)
  end

  it "should error when the value is not acceptable" do
    expect { Card.new({:value => :cake}) }.to raise_error(RuntimeError)
  end

  it "should error when the suit is not acceptable" do
    expect { Card.new({:suit  => :cake}) }.to raise_error(RuntimeError)
  end

  describe "#face_card?" do

    it "is true when it is a face card" do
      card = Card.new({:value => Card::FACES.sample})
      expect(card.face_card?).to be true
    end

    it "is false when it is a pip card" do
      card = Card.new({:value => rand(1..10)})
      expect(card.face_card?).to be false
    end

  end

  describe "#pip_card?" do

    it "is false when it is a face card" do
      card = Card.new({:value => Card::FACES.sample})
      expect(card.pip_card?).to be false
    end

    it "is true when it is a pip card" do
      card = Card.new({:value => rand(1..10)})
      expect(card.pip_card?).to be true
    end

  end

  describe "#to_s?" do

    it "should match 'the {value} of {suit}'" do
      card = Card.new({:value => Card::VALUES.select { |v|  v != 1  }.sample})
      expect(card.to_s).to eq("the #{card.value} of #{card.suit}")
    end

    it "should handle aces as an exception" do
      card = Card.new({:value => 1})
      expect(card.to_s).to eq("the ace of #{card.suit}")
    end

  end

  describe "#to_short_s?" do

    it "should match '{v}:{s}'" do
      card = Card.new({:value => 1, :suit => Card::SPADES})
      expect(card.to_short_s).to eq("1:S")
    end

  end

  describe ".convert_short_string_to_hash" do
    it "should convert a string that matches '{v}:{s}' to the requisite hash" do
      card_hash    = {:value => 1, :suit => Card::SPADES}
      card         = Card.new(card_hash)
      short_string = card.to_short_s
      expect(Card.convert_short_string_to_hash(short_string)).to eq(card_hash)
    end

    it "should handle numeric values greater than 10" do
      card_hash    = {:value => 12, :suit => Card::DIAMONDS}
      card         = Card.new(card_hash)
      short_string = card.to_short_s

      card_hash[:value] = Card::QUEEN
      expect(Card.convert_short_string_to_hash(short_string)).to eq(card_hash)
    end
  end

  describe ".value_sorter" do

    it "should return shuffled VALUES back to their original order" do
      shuffled_values = Card::VALUES.shuffle
      sorted_values   = shuffled_values.sort {|a,b| Card.value_sorter a, b}
      expect(sorted_values).to eq(Card::VALUES)
    end

  end
end