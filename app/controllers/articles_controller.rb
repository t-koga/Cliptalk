class ArticlesController < ApplicationController
  before_action :authenticate_user

  def index
    @room = Room.find_by(id: params[:room_id])
    @super_room = Room.find_by(id: @room.super_room_id)
    @rooms = Room.where(super_room_id: @room.id).page(params[:page])
    @articles = Article.where(room_id: @room.id)
  end

  def new
    @article = Article.new
    @room = Room.find_by(id: params[:room_id])
  end

  def create
    @article = Article.new(
      room_id: params[:room_id],
      user_id: @current_user.id,
      title: params[:title],
      content: params[:content])
    if @article.save
      flash[:notice] = "新しいクリップを作成しました"
      redirect_to(articles_path(@article.room_id))
    else
      @room = Room.find_by(id: params[:room_id])
      @title = params[:title]
      @content = params[:content]
      render("articles/new")
    end
  end

  def show
    @room = Room.find_by(id: params[:room_id])
    @article = Article.find_by(id: params[:article_id])
    @comments = Comment.where(article_id: @article.id)
    @comment = Comment.new
  end

end
