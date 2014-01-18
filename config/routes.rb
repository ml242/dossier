Dossier::Application.routes.draw do
  root to: 'welcome#index'

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/signout', to: 'sessions#destroy', as: 'signout'
  match '/auth/failure', to: redirect('/')

end
