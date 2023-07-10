Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    resources :items, only: [:index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]

    get "customers/mypage" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/confirm_withdraw" => "customers#confirm"
    patch "customers/withdraw" => "customers#withdraw"

    resources :genres do
      member do
        get "search"
      end
    end

    resources :cart_items, only: [:create, :index, :update, :destroy] do
      collection do
        delete "destroy_all"
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "confirm"
        get "complete"
      end
    end
  end




#管理者側のルーティング設定
namespace :admin do
  get "/" => "homes#top"
  resources :items,     only: [:new, :create, :index, :show, :edit, :update]
  resources :genres,    only: [:index, :create, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
