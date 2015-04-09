Rails.application.routes.draw do

  root 'card_shuffler#index'

  post 'shuffle(/:type)' => 'card_shuffler#shuffle'

end
