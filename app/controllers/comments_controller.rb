class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_group

  def create
    @comment = Comment.new(
      article_id: params[:article_id],
      user_id: @current_user.id,
      group_id: @current_group.id,
      content: params[:content])
    if @comment.save
      flash[:notice] = "新しいトークを作成しました"
      @article = Article.find_by(id: @comment.article_id)
      @article.comment_count += 1
      @article.save
      redirect_to(show_article_path(params[:room_id], params[:article_id]))
    else
      @content = params[:content]
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
