Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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
  get "/receipts/favourite/:id", to: "receipt#add_favourite"
  # удаляет из избранного
  delete "/receipts/favourite/:id", to: "receipt#delete_favourite"
  # удаляет рецепт по id
  delete "/receipt/:id", to: "receipt#delete_receipt"
  # возвращает рецепт по идентификатору
  get "/receipt/:id", to: "receipt#receipt_id"
  # возвращает все рецепты пользователей, на которых он подписан
  get "/receipts/subscriptions", to: "receipt#subscriptions_receipts"
  # вовзращает рецепт авторизованного пользователя
  get "/receipts/:id", to: "receipt#receipts_by_user_id"


  # возвращает всех подписчиков пользователя
  get "/user/subscribers", to:  "subscription#subscribers"
  # возвращает все подписки пользователя
  get "/user/subscriptions", to: "subscription#subscriptions"
  # подписывает пользователя
  post "/user/subscribe/:id", to: "subscription#subscribe"
  get "/user/:id", to: "login#get_user_by_id"

  post "/user/photo", to: "login#add_photo"

  delete "/user/photo", to: "login#delete_photo"

  # подписан ли пользователь на кого-то
  get "user/subscribed/:id", to: "subscription#is_user_subscribed"
  # отписывает пользователя от человека по его id
  delete "/user/unsubscribe/:id", to: "subscription#unsubscribe"

  # авторизация пользователя
  post "/login", to: "login#login"
  # возвращает данные пользователя
  get "/user", to: "login#user"
  # возврашает данные пользователя по его id
  get "/user/info/:id", to: "login#user_info_by_id"

  get "/user/:id", to: "login#get_user_by_id"

  # возвращает все рецепты
  get "/search/all", to: "search#index"
end 