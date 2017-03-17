Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :subforums do
    resources :posts, except: [:index] do
      member do
        post "upvote"
        post "downvote"
      end

      resources :comments, except: [:index] do
        member do
          post "upvote"
          post "downvote"
        end
      end
    end
  end

  root to: redirect("/users/new")
end
