Rails.application.routes.draw do
  get "/" => "home#index", as: "top"

  get "/users/new" => "users#new", as: "new_user"
  post "/users/new" => "users#create", as: "create_user"
  get "/users/:user_id" => "users#show", as: "show_user"
  get "/users/:user_id/edit" => "users#edit", as: "edit_user"
  post "/users/:user_id/edit" => "users#update", as: "update_user"
  get "/login" => "users#login_form", as: "login_form"
  post "/login" => "users#login", as: "login"
  post "/logout" => "users#logout", as: "logout"

  get "/rooms" => "rooms#index", as: "rooms"
  get "/rooms/:room_id/new" => "rooms#new", as: "new_room"
  post "/rooms/:room_id/new" => "rooms#create", as: "create_room"
  get "/rooms/:room_id/edit" => "rooms#edit", as: "edit_room"
  post "/rooms/:room_id/edit" => "rooms#update", as: "update_room"
  get "/rooms/:room_id/edit/manager" => "rooms#manager_edit", as: "edit_room_manager"
  post "/rooms/:room_id/edit/manager" => "rooms#manager_change", as: "change_room_manager"

  get "/rooms/:room_id/articles" => "articles#index", as: "articles"
  get "/rooms/:room_id/articles/new" => "articles#new", as: "new_article"
  post "/rooms/:room_id/articles/new" => "articles#create", as: "create_article"
  get "/rooms/:room_id/articles/:article_id" => "articles#show", as: "show_article"
  post "/rooms/:room_id/articles/:article_id/status" => "articles#status", as: "status_article"
  get "/rooms/:room_id/articles/:article_id/edit" => "articles#edit", as: "edit_article"
  post "/rooms/:room_id/articles/:article_id/edit" => "articles#update", as: "update_article"

  post "/rooms/:room_id/articles/:article_id/comments" => "comments#create", as: "create_comment"


end
