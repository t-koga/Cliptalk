class ArticlesController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_group
  before_action :ensure_correct_writer, {only: [:status, :edit, :update]}

  def index
    @room = Room.find_by(id: params[:room_id])
    @super_room = Room.find_by(id: @room.super_room_id)
    @rooms = Room.where(is_destroyed: false).where(super_room_id: @room.id).page(params[:room_page])
    @articles = Article.where(is_destroyed: false).where(room_id: @room.id).page(params[:article_page])
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
      content: params[:content],
      comment_count: 0,
      group_id: @current_group.id,
      is_solved: false,
      is_destroyed: false)
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

  def status
    @article = Article.find_by(id: params[:article_id])
    @article.is_solved = !(@article.is_solved) # boolean反転
    @article.save
    flash[:notice] = "ステータスを変更しました"
    redirect_to(show_article_path(params[:room_id], params[:article_id]))
  end

  def edit
    @article = Article.find_by(id: params[:article_id])
  end

  def update
    @article = Article.find_by(id: params[:article_id])
    @article.title = params[:title]
    @article.content = params[:content]
    if @article.save
      flash[:notice] = "クリップを更新しました"
      redirect_to(show_article_path(params[:room_id], params[:article_id]))
    else
      render("articles/edit")
    end
  end

  def destroy
    @article = Article.find_by(id: params[:article_id])
    @article.is_destroyed = true
    @article.save
    flash[:notice] = "クリップを削除しました"
    redirect_to(articles_path(params[:room_id]))
  end

  # 記事作成者以外の編集を制限
  def ensure_correct_writer
    @article = Article.find_by(id: params[:article_id])
    unless @current_user.id == @article.user_id
      flash[:notice] = "クリップ作成者以外の編集はできません"
      redirect_to(show_article_path(params[:room_id], params[:article_id]))
    end
  end

  # 他グループのURLを制限
  def ensure_correct_group
    unless @current_group.id == Room.find_by(id: params[:room_id].to_i).group_id
      flash[:notice] = "他のグループ情報は閲覧できません"
      redirect_to(rooms_path)
    end
  end
end
