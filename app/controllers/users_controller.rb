class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:logout, :show]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password])
      @user.avatar.attach(
        io: File.open(Rails.root.join("storage/default_image.jpg")),
        filename: "default_image.jpg",
        content_type: "image/jpg")
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to(rooms_path)
    else
      @name = params[:name]
      @email = params[:email]
      @password = params[:password]
      render("users/new")
    end
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @rooms = Room.where(user_id: params[:user_id]).page(params[:room_page])
    @articles = Article.where(user_id: params[:user_id]).page(params[:article_page])
  end

  def edit
    @user = User.find_by(id: @current_user.id)
  end

  def update
    @user = User.find_by(id: @current_user.id)
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    if params[:avatar]
      @user.avatar = params[:avatar]
    end
    if @user.save
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to(show_user_path(@current_user.id))
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to(rooms_path)
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to(top_path)
  end

  # 他ユーザーの編集を制限
  def ensure_correct_user
    unless @current_user.id == params[:user_id].to_i
      flash[:notice] = "他のユーザーの編集はできません"
      redirect_to(show_user_path(@current_user.id))
    end
  end

end
