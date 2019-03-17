class RoomsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_group, {except: [:index]}
  before_action :ensure_correct_manager, {only: [:edit, :update, :manager_edit, :manager_change]}

  def index
    @rooms = Room.where(is_destroyed: false).where(super_room_id: 0).where(group_id: @current_group.id).page(params[:page])
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
    @room.icon.attach(
      io: File.open(Rails.root.join("storage/default_room_image.jpg")),
      filename: "default_room_image.jpg",
      content_type: "image/jpg")
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
  end

  def update
    @room = Room.find_by(id: params[:room_id])
    @room.name = params[:name]
    if params[:icon]
      @room.icon = params[:icon]
    end
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
    @user = User.find_by(name: params[:name], email: params[:email])
    if @user
      if GroupUser.where(group_id: @current_group.id).find_by(user_id: @user.id)
        @room.user_id = @user.id
        @room.save
        flash[:notice] = "部屋の管理者を変更しました"
        redirect_to(articles_path(@room.id))
      else
        @error_message = "他のグループのユーザーは管理者にできません"
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
    @articles = Article.where(room_id: @room.id).where(is_destroyed: false).page(params[:article_page])
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
      @error_message = "小部屋がある部屋は削除できません"
      render("articles/index")
    end
  end

  # 部屋管理者以外の編集を制限
  def ensure_correct_manager
    @room = Room.find_by(id: params[:room_id])
    unless @current_user.id == @room.user_id
      flash[:notice] = "部屋管理者以外の編集はできません"
      redirect_to(articles_path(@room.id))
    end
  end

  # 他グループのURLを制限
  def ensure_correct_group
    unless params[:room_id] == "0"
      unless @current_group.id == Room.find_by(id: params[:room_id].to_i).group_id
        flash[:notice] = "他のグループ情報は閲覧できません"
        redirect_to(rooms_path)
      end
    end
  end
end
