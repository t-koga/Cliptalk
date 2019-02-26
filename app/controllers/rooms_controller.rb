class RoomsController < ApplicationController
  before_action :authenticate_user

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(name: params[:name])
    if @room.save
      flash[:notice] = "新しい部屋を作成しました"
      redirect_to(rooms_path)
    else
      @name = params[:name]
      render("rooms/new")
    end
  end

end
