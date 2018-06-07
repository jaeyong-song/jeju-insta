Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}
  root 'posts#index'
  resources :posts do
    post 'like' => 'posts#like', as: :like, on: :member
    # posts/:post_id/like로 되지 않고, posts/:id/like로 인식되려면
    # on 입력
    # as는 별칭을 만들어주는 것! -> like_post_path가 생김
  end
  
  resources :users, only: [:show] do
    post 'follow' => 'users#follow', as: :follow, on: :member
  end
  
  # post 'posts/:id/like' => 'posts#like'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end