class CommentsController < ApplicationController


  def index
    @comments = Comment.all
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
      respond_to  do |format|
        format.html { 
          redirect_to article_path(@article)
        }
        format.json {
          render json: @comment
        }
    end
  end
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@article), status: :see_other }
      format.json {}
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
