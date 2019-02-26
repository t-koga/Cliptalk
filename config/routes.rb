Rails.application.routes.draw do
  get "/" => "home#index", as: "top"

  get "/users/new" => "users#new", as: "new_user"
  post "/users/new" => "users#create", as: "create_user"
  get "/login" => "users#login_form", as: "login_form"
  post "/login" => "users#login", as: "login"
  post "/logout" => "users#logout", as: "logout"

  get "/rooms" => "rooms#index", as: "rooms"
  get "/rooms/new" => "rooms#new", as: "new_room"
  post "/rooms" => "rooms#create", as: "create_room"

  get "/rooms/:room_id/articles" => "articles#index", as: "articles"
  get "/rooms/:room_id/articles/new" => "articles#new", as: "new_article"
  post "/rooms/:room_id/articles/new" => "articles#create", as: "create_article"
  get "/rooms/:room_id/articles/:article_id" => "articles#show", as: "show_article"

  post "/rooms/:room_id/articles/:article_id/comments" => "comments#create", as: "create_comment"


end
