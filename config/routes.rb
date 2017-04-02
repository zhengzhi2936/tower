Rails.application.routes.draw do
   devise_for :user, controllers: {
     passwords: 'users/passwords',
     registrations: 'users/registrations',
     sessions: 'users/sessions'
   }
   resources :teams do
     resources :projects do
       resources :todos do
         member do
           post :receive_todo
           post :finish_todo
           post :reopen_todo
           post :cancel_todo
           post :renew_todo
         end
         resources :reviews
       end
     end
   end
   root 'teams#index'

end
