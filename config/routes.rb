Rails.application.routes.draw do
  get "/" => "home#index", as: "top"
  get "/groups/new" => "groups#new", as: "new_group"
  post "/groups/new" => "groups#create", as: "create_group"

  get "/groups/:group_url" => "groups#index", as: "top_group"
  get "/groups/:group_url/users/new" => "users#new", as: "new_user"
  post "/groups/:group_url/users/new" => "users#create", as: "create_user"
  get "/groups/:group_url/login" => "users#login_form", as: "login_form"
  post "/groups/:group_url/login" => "users#login", as: "login"

  get "/groups/:group_url/garbage" => "groups#garbage", as: "garbage_group"
  get "/groups/:group_url/manager_login" => "groups#login_form", as: "manager_login_form"
  post "/groups/:group_url/manager_login" => "groups#login", as: "manager_login"
  get "/groups/:group_url/edit" => "groups#edit", as: "edit_group"
  post "groups/:group_url/edit" => "groups#update", as: "update_group"
  post "/groups/:group_url/manager_logout" => "groups#logout", as: "manager_logout"

  get "/users" => "users#index", as: "users"
  get "/users/:user_id" => "users#show", as: "show_user"
  get "/users/:user_id/edit" => "users#edit", as: "edit_user"
  post "/users/:user_id/edit" => "users#update", as: "update_user"
  post "/users/:user_id/destroy" => "users#destroy", as: "destroy_user"
  post "/logout" => "users#logout", as: "logout"

  get "/rooms" => "rooms#index", as: "rooms"
  get "/rooms/:room_id/new" => "rooms#new", as: "new_room"
  post "/rooms/:room_id/new" => "rooms#create", as: "create_room"
  get "/rooms/:room_id/edit" => "rooms#edit", as: "edit_room"
  post "/rooms/:room_id/edit" => "rooms#update", as: "update_room"
  get "/rooms/:room_id/edit/manager" => "rooms#manager_edit", as: "edit_room_manager"
  post "/rooms/:room_id/edit/manager" => "rooms#manager_change", as: "change_room_manager"
  post "/rooms/:room_id/destroy" => "rooms#destroy", as: "destroy_room"

  get "/rooms/:room_id/articles" => "articles#index", as: "articles"
  get "/rooms/:room_id/articles/new" => "articles#new", as: "new_article"
  post "/rooms/:room_id/articles/new" => "articles#create", as: "create_article"
  get "/rooms/:room_id/articles/:article_id" => "articles#show", as: "show_article"
  post "/rooms/:room_id/articles/:article_id/status" => "articles#status", as: "status_article"
  get "/rooms/:room_id/articles/:article_id/edit" => "articles#edit", as: "edit_article"
  post "/rooms/:room_id/articles/:article_id/edit" => "articles#update", as: "update_article"
  post "/rooms/:room_id/articles/:article_id/destroy" => "articles#destroy", as: "destroy_article"

  post "/rooms/:room_id/articles/:article_id/comments" => "comments#create", as: "create_comment"


end
