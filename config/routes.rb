Dossier::Application.routes.draw do
  root to: 'welcome#index'

  post '/linkedinauth', to: 'sessions#linked_in_auth'
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/signout', to: 'sessions#destroy', as: 'signout'
  match '/auth/failure', to: redirect('/')

end
