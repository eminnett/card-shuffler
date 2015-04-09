require "rails_helper"

describe "Deck" do

  it "should not contain any duplicate Cards" do
    cardStrings = []
    deck        = Deck.new
    deckCount   = deck.count

    deckCount.times do
      cardStrings.push deck.pop.to_s
    end

    expect(cardStrings.uniq.count).to equal(deckCount)
  end

  it "should represent all the suits" do
    suitsInDeck = []
    deck        = Deck.new
    deckCount   = deck.count

    deckCount.times do
      suitsInDeck.push deck.pop.suit
    end

    expect(suitsInDeck.uniq.sort).to eq(Card::SUITS.uniq.sort)
  end

  it "should represent all the values" do
    valuesInDeck = []
    deck        = Deck.new
    deckCount   = deck.count

    deckCount.times do
      valuesInDeck.push deck.pop.value
    end

    sorted_values_in_deck = valuesInDeck.uniq.sort {|a,b| Card.value_sorter a, b}
    sorted_suits          = Card::VALUES.sort {|a,b| Card.value_sorter a, b}
    expect(sorted_values_in_deck).to eq(sorted_suits)
  end

  describe "#count" do
    it "should have a count of 52" do
      expect(Deck.new.count).to equal(52)
    end
  end
end