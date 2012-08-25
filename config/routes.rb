PenaltiesGame::Application.routes.draw do
  resources :games do
    member do
      post 'shoot'
    end
  end
end
