class CardShufflerController < ActionController::Base

  def index
    @stack = Deck.new
  end


  def shuffle
    shuffle_type = params.has_key?(:type) \
            ? params[:type].gsub(/-/, "_").to_sym \
            : :shuffle

    unless Shuffler.method_defined? shuffle_type
      shuffle_type    = :shuffle
      flash[:warning] = "#{params[:type]} is not a supported shuffle type. " + \
            "We have used the default shuffle method instead."
    end

    @stack    = CardStack.new
    card_data = params[:card_data]

    card_data.each do |card_datum|
      @stack.push Card.new(card_datum)
    end

    @stack = Shuffler.send(shuffle_type, @stack)[:shuffled_stack]

    render :index
  end

end