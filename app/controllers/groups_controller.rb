class GroupsController < ApplicationController
  before_action :authenticate_user, {only: [:login_form, :login, :garbage, :edit, :update, :logout]}
  before_action :forbid_login_user, {only: [:new, :create]}
  before_action :restrict_no_exist_group, {only: [:login_form, :login, :garbage, :edit, :update, :logout]}
  before_action :ensure_correct_group, {only: [:login_form, :login, :garbage, :edit, :update, :logout]}
  before_action :authenticate_manager, {only: [:edit, :update, :logout]}
  before_action :forbid_login_manager, {only: [:login_form, :login]}

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(
      url: params[:url],
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation])
    if @group.save
      flash[:notice] = "グループ登録が完了しました"
      redirect_to(top_group_path(@group.url))
    else
      @url = params[:url]
      @name = params[:name]
      @email = params[:email]
      @password = params[:password]
      render("groups/new")
    end
  end

  def index
    @group = Group.find_by(url: params[:group_url])
  end

  def login_form
  end

  def login
    @group = Group.find_by(email: params[:email], url: params[:group_url])
    if @group && @group.authenticate(params[:password])
      if User.where(group_id: @group.id).find_by(id: @current_user.id)
        session[:manager_id] = @current_user.id
        flash[:notice] = "管理者としてログインしました"
        redirect_to(rooms_path)
      else
        @error_message = "他のグループにはログインできません"
        @email = params[:email]
        @password = params[:password]
        render("groups/login_form")
      end
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("groups/login_form")
    end
  end

  def garbage
    @users = User.where(is_destroyed: true).where(group_id: @current_group.id).order(id: :desc).page(params[:user_page]).per(50)
    @rooms = Room.where(is_destroyed: true).where(group_id: @current_group.id).order(id: :desc).page(params[:room_page]).per(50)
    @articles = Article.where(is_destroyed: true).where(group_id: @current_group.id).order(id: :desc).page(params[:article_page]).per(50)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @group = Group.find_by(id: @current_group.id)
  end

  def update
    @group = Group.find_by(id: @current_group.id)
    @group.url = params[:url]
    @group.name = params[:name]
    @group.email = params[:email]
    @group.password = params[:password]
    @group.password_confirmation = params[:password_confirmation]
    if @group.save
      flash[:notice] = "グループ情報を更新しました"
      redirect_to(rooms_path)
    else
      render("groups/edit")
    end
  end

  def logout
    session[:manager_id] = nil
    flash[:notice] = "管理者をログアウトしました"
    redirect_to(rooms_path)
  end

  # 存在しないグループのURLを制限
  def restrict_no_exist_group
    unless Group.find_by(url: params[:group_url])
      flash[:alert] = "このページにはアクセスできません"
      redirect_to(rooms_path)
    end
  end

  # 他グループのURLを制限
  def ensure_correct_group
    unless @current_group.id == Group.find_by(url: params[:group_url]).id
      flash[:alert] = "このページにはアクセスできません"
      redirect_to(rooms_path)
    end
  end
end
