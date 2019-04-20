class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:logout, :index, :show, :edit]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_group, {only: [:edit, :update, :show]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  # ログイン前のアクション(forbid_login_user)---
  def new
    @user = User.new
    @group = Group.find_by(url: params[:group_url])
  end

  def create
    @group = Group.find_by(url: params[:group_url])
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      group_id: @group.id,
      is_destroyed: false)
      # 画像機能見送り
      # @user.avatar.attach(
      #   io: File.open(Rails.root.join("storage/default_image.jpg")),
      #   filename: "default_image.jpg",
      #   content_type: "image/jpg")
    if @user.save
      session[:user_id] = @user.id
      session[:group_id] = @group.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to(rooms_path)
    else
      @name = params[:name]
      @email = params[:email]
      @password = params[:password]
      render("users/new")
    end
  end

  def login_form
    @group = Group.find_by(url: params[:group_url])
  end

  def login
    @group = Group.find_by(url: params[:group_url])
    @user = User.where(group_id: @group.id).find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      unless @user.is_destroyed
        session[:user_id] = @user.id
        session[:group_id] = @group.id
        flash[:notice] = "ログインしました"
        redirect_to(rooms_path)
      else
        @error_message = "そのユーザーはログイン権限がありません"
        @email = params[:email]
        @password = params[:password]
        render("users/login_form")
      end
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  # ---ログイン前のアクション(forbid_login_user)

  # ログイン後のアクション(authenticate_user)---
  def index
    @users = User.where(is_destroyed: false).where(group_id: @current_group.id).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @rooms = Room.where(is_destroyed: false).where(user_id: params[:user_id]).page(params[:room_page])
    @articles = Article.where(is_destroyed: false).where(user_id: params[:user_id]).order(id: :desc).page(params[:article_page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @user = User.find_by(id: @current_user.id)
  end

  def update
    @user = User.find_by(id: @current_user.id)
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    # 画像機能見送り
    # if params[:avatar]
    #   @user.avatar.attach(params[:avatar])
    # end
    if @user.save
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to(show_user_path(@current_user.id))
    else
      render("users/edit")
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @user.is_destroyed = true
    @user.save
    @rooms = Room.where(user_id: @user.id).where(is_destroyed: false)
    @rooms.each do |room|
      room.user_id = @current_manager.id
      room.save
    end
    flash[:notice] = "ユーザーを削除しました"
    redirect_to(users_path)
  end

  def logout
    url = Group.find_by(id: @current_group.id).url
    session[:user_id] = nil
    session[:group_id] = nil
    session[:manager_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to(top_group_path(url))
  end
  # ---ログイン後のアクション(authenticate_user)

  # 他ユーザーの編集を制限
  def ensure_correct_user
    unless @current_user.id == params[:user_id].to_i
      flash[:alert] = "他のユーザーの編集はできません"
      redirect_to(show_user_path(@current_user.id))
    end
  end

  # 他グループのURLを制限
  def ensure_correct_group
    unless @current_group.id == User.find_by(id: params[:user_id].to_i).group_id
      flash[:alert] = "このページにはアクセスできません"
      redirect_to(rooms_path)
    end
  end
end
