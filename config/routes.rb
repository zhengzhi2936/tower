Rails.application.routes.draw do
   devise_for :user, controllers: {
     passwords: 'users/passwords',
     registrations: 'users/registrations',
     sessions: 'users/sessions'
   }
   resources :teams do
     resources :projects do
       resources :todos do
         resources :reviews
       end
     end
   end
   root 'teams#index'

end
