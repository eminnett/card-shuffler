Rails.application.routes.draw do

  root 'card_shuffler#index'

  get 'shuffle(/:type)' => 'card_shuffler#shuffle'

end
