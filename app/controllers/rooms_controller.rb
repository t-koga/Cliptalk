class RoomsController < ApplicationController
  before_action :authenticate_user
  before_action :restrict_no_exist_room, {except: [:index]}
  before_action :ensure_correct_group, {except: [:index]}
  before_action :ensure_correct_manager, {only: [:edit, :update, :manager_edit, :manager_change]}
  before_action :ensure_destroyed_room, {only: [:new, :create, :edit, :update, :manager_edit, :manager_change]}

  def index
    @rooms = Room.where(is_destroyed: false).where(super_room_id: 0).where(group_id: @current_group.id).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @room = Room.new
    @super_room = Room.find_by(id: params[:room_id])
  end

  def create
    @room = Room.new(
      name: params[:name],
      user_id: @current_user.id,
      super_room_id: params[:room_id],
      group_id: @current_group.id,
      is_destroyed: false)
    # 画像機能見送り
    # @room.icon.attach(
    #   io: File.open(Rails.root.join("storage/default_room_image.jpg")),
    #   filename: "default_room_image.jpg",
    #   content_type: "image/jpg")
    if @room.save
      flash[:notice] = "新しい部屋を作成しました"
      if @room.super_room_id == 0
        redirect_to(rooms_path)
      else
        redirect_to(articles_path(@room.super_room_id))
      end
    else
      @super_room = Room.find_by(id: params[:room_id])
      @name = params[:name]
      render("rooms/new")
    end
  end

  def edit
    @room = Room.find_by(id: params[:room_id])
    @room_name = @room.name
  end

  def update
    @room = Room.find_by(id: params[:room_id])
    @room_name = @room.name
    @room.name = params[:name]
    # 画像機能見送り
    # if params[:icon]
    #   @room.icon = params[:icon]
    # end
    if @room.save
      flash[:notice] = "部屋情報を更新しました"
      redirect_to(articles_path(@room.id))
    else
      render("rooms/edit")
    end
  end

  def manager_edit
  end

  def manager_change
    @room = Room.find_by(id: params[:room_id])
    @user = User.where(group_id: @current_group.id).find_by(name: params[:name], email: params[:email])
    if @user
      unless @user.is_destroyed
        @room.user_id = @user.id
        @room.save
        flash[:notice] = "部屋の管理者を変更しました"
        redirect_to(articles_path(@room.id))
      else
        @error_message = "削除されているユーザーは管理者に変更できません"
        @name = params[:name]
        @email = params[:email]
        render("rooms/manager_edit")
      end
    else
      @error_message = "名前またはメールアドレスが間違っています"
      @name = params[:name]
      @email = params[:email]
      render("rooms/manager_edit")
    end
  end

  def destroy
    @room = Room.find_by(id: params[:room_id])
    @super_room = Room.find_by(id: @room.super_room_id)
    @rooms = Room.where(is_destroyed: false).where(super_room_id: @room.id).page(params[:room_page])
    @articles = Article.where(room_id: @room.id).where(is_destroyed: false).order(id: :desc).page(params[:article_page])
    if Room.where(super_room_id: @room.id).where(is_destroyed: false).count == 0
      @articles.each do |article|
        article.is_destroyed = true
        article.save
      end
      @room.is_destroyed = true
      @room.save
      flash[:notice] = "部屋を削除しました"
      redirect_to(rooms_path)
    else
      flash.now[:alert] = "小部屋がある部屋は削除できません"
      render("articles/index")
    end
  end

  # 部屋管理者以外の編集を制限
  def ensure_correct_manager
    @room = Room.find_by(id: params[:room_id])
    unless @current_user.id == @room.user_id
      flash[:alert] = "部屋管理者以外は編集できません"
      redirect_to(articles_path(@room.id))
    end
  end

  # 削除された部屋の編集を制限
  def ensure_destroyed_room
    unless params[:room_id] == "0"
      if Room.find_by(id: params[:room_id].to_i).is_destroyed
        flash[:alert] = "削除された部屋は編集できません"
        redirect_to(rooms_path)
      end
    end
  end

  # 存在しない部屋のURLを制限
  def restrict_no_exist_room
    unless params[:room_id] == "0"
      unless Room.find_by(id: params[:room_id])
        flash[:alert] = "このページにはアクセスできません"
        redirect_to(rooms_path)
      end
    end
  end

  # 他グループのURLを制限
  def ensure_correct_group
    unless params[:room_id] == "0"
      unless @current_group.id == Room.find_by(id: params[:room_id].to_i).group_id
        flash[:alert] = "このページにはアクセスできません"
        redirect_to(rooms_path)
      end
    end
  end

end
