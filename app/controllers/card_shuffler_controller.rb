class CardShufflerController < ActionController::Base

  layout "application"

  # Responds to a GET request for the root page.
  def index
    @stack        = Deck.new
    @option_title = "You have a new deck of cards."
    @shuffled     = false
  end

  # Responds to a GET request the intention that the given deck
  # of cards will be shuffled with the requested shuffle type.
  def shuffle

    unless shuffle_type_is_appropriate params
      flash[:warning] = "#{params[:type]} is not a supported shuffle type. " + \
            "We have used the default shuffle method instead."
    end

    unless params.has_key?(:deck)
      flash[:warning] = "Your deck of cards has disappeared! Here is a new one."
      return redirect_to "/"
    end

    @stack        = shuffle_the_deck params
    @option_title = "Your deck has been shuffled using the " + \
      "#{snakecase_symbol_to_plain_text(@shuffle_type)} technique."
    @shuffled     = true

    render :index
  end

  private

  # Determines which shuffle technique to use given the inclusion
  # or not aof a type value in the params and whether the given
  # type is an acceptable value.
  def shuffle_type_is_appropriate(params)
    @shuffle_type = :shuffle
    @shuffle_type = slug_to_snakecase_symbol(params[:type]) if  params.has_key?(:type)

    shuffle_type_defined = Shuffler.methods(false).include? @shuffle_type

    # Revert to the default if necessary.
    @shuffle_type = :shuffle unless shuffle_type_defined

    shuffle_type_defined
  end

  # Converts a given hyphen seperated slug to a snakecase symbol.
  def slug_to_snakecase_symbol(slug)
    slug.gsub(/-/, "_").to_sym
  end

  # Converts a given snakecase symbol into a plain text string.
  def snakecase_symbol_to_plain_text(snakecase)
    snakecase.to_s.gsub(/_/, " ")
  end

  # Assuming that a deck of cards is defined using the short
  # string abbreviation of each card and is assigned to the
  # deck property of the params, convert the data string into
  # a populated CardStack and shuffle it.
  def shuffle_the_deck(params)
    stack     = CardStack.new
    card_data = params[:deck]

    card_data.split(",").each do |datum|
      card_hash = Card.convert_short_string_to_hash datum
      stack.push  Card.new(card_hash)
    end

    Shuffler.send(@shuffle_type, stack)[:shuffled_stack]
  end

end