Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: proc { [200, {}, ['']] }

  # регистрация пользователя
  post "/registration", to: "registration#create"

  # возвращает все рецепты зарегистрированного пользователя
  get "/receipts", to: "receipt#index"
  # создаёт рецепт зарегистрированного пользователя
  post "/receipt", to: "receipt#create_receipt"
  # возвращает все избранные рецепты зарегистрированного пользователя
  get "/receipts/favourite", to: "receipt#favourites"
  # добавляет рецепт зарегистрированного пользователя в избранные
  post "/receipts/favourite/:id", to: "receipt#add_favourite"
  # возвращает рецепт по идентификатору
  get "/receipt/:id", to: "receipt#receipt_id"

  # возвращает всех подписчиков пользователя
  get "/user/subscribers", to:  "subscription#subscribers"
  # возвращает все подписки пользователя
  get "/user/subscriptions", to: "subscription#subscriptions"
  # подписывает пользователя
  post "/user/subscribe/:id", to: "subscription#subscribe"

  # авторизация пользователя
  post "/login", to: "login#login"
  # возвращает данные пользователя
  get "/user", to: "login#user"

  # возвращает все рецепты
  get "/search/all", to: "search#index"
end 