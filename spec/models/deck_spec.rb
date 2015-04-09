require "rails_helper"

describe "Deck" do

  it "should not contain any duplicate Cards" do
    card_strings = []
    deck         = Deck.new
    deck_count   = deck.count

    deck_count.times do
      card_strings.push deck.pop.to_s
    end

    expect(card_strings.uniq.count).to equal(deck_count)
  end

  it "should represent all the suits" do
    suits_in_deck = []
    deck          = Deck.new
    deck_count    = deck.count

    deck_count.times do
      suits_in_deck.push deck.pop.suit
    end

    expect(suits_in_deck.uniq.sort).to eq(Card::SUITS.uniq.sort)
  end

  it "should represent all the values" do
    values_in_deck = []
    deck           = Deck.new
    deck_count     = deck.count

    deck_count.times do
      values_in_deck.push deck.pop.value
    end

    sorted_values_in_deck = values_in_deck.uniq.sort {|a,b| Card.value_sorter a, b}
    sorted_suits          = Card::VALUES.sort {|a,b| Card.value_sorter a, b}
    expect(sorted_values_in_deck).to eq(sorted_suits)
  end

  describe "#count" do
    it "should have a count of 52" do
      expect(Deck.new.count).to equal(52)
    end
  end
end