require "rails_helper"

describe Card, type: :model do
  it "should have an acceptable value by default" do
    expect(Card::VALUES).to include(Card.new.value)
  end

  it "should have an acceptable suit by default" do
    expect(Card::SUITS).to include(Card.new.suit)
  end

  it "should error when the value is not acceptable" do
    expect(Card.new({:value => :cake})).to raise_error
  end

  it "should error when the suit is not acceptable" do
    expect(Card.new({:suit  => :cake})).to raise_error
  end

  describe "#face_card?" do

    it "is true when it a face card" do
      card = Card.new({:value => Card::FACES.sample})
      expect(card.face_card?).to be true
    end

    it "is false when it a pip card" do
      card = Card.new({:value => rand(1..10)})
      expect(card.face_card?).to be false
    end

  end

  describe "#pip_card?" do

    it "is false when it a face card" do
      card = Card.new({:value => Card::FACES.sample})
      expect(card.face_card?).to be false
    end

    it "is true when it a pip card" do
      card = Card.new({:value => rand(1..10)})
      expect(card.face_card?).to be true
    end

  end
end