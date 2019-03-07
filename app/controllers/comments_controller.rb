class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    @comment = Comment.new(
      article_id: params[:article_id],
      user_id: @current_user.id,
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

end
