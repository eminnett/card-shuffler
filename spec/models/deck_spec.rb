require "rails_helper"

describe "Deck" do

  def get_deck_data(card_method, return_deck_count = false)
    data       = []
    deck       = Deck.new
    deck_count = deck.count

    deck_count.times do
      data.push deck.pop.send(card_method)
    end

    if return_deck_count
      return data, deck_count
    end

    data
  end

  it "should not contain any duplicate Cards" do
    return_deck_count = true
    card_strings, deck_count = get_deck_data :to_s, return_deck_count

    expect(card_strings.uniq.count).to equal(deck_count)
  end

  it "should represent all the suits" do
    suits_in_deck = get_deck_data :suit

    expect(suits_in_deck.uniq.sort).to eq(Card::SUITS.uniq.sort)
  end

  it "should represent all the values" do
    values_in_deck = get_deck_data :value

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