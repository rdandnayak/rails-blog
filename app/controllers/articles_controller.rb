class ArticlesController < ApplicationController
  # include ActionController::MimeResponds

  def index
    @articles = Article.all
    # render json: @articles
      # respond_to :json, :html
    respond_to do |format|
      format.html 
      format.json { render json: @articles }
    end
  end
  def show
    @article = Article.find(params[:id])
    # render json: @article
    respond_to do |format|
      format.html 
      format.json { render json: @article }
    end
  end
  def new
    @article = Article.new
  end 
  def create
    @article = Article.new(article_params)

    if(@article.save)
      respond_to do |format|
        format.html { redirect_to @article }
        format.json { 
          render json: @article, status: :created, location: @article
        }
      end
    else
      respond_to do |format|
        format.html {
          render :new, status: :unprocessable_entity
        }
        format.json { 
          render json: @article.errors, status: :unprocessable_entity
        }
      end
    end
  end
  def edit
    @article = Article.find(params[:id])
  end
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      respond_to do |format|
        format.html { redirect_to @article }
        format.json { 
          render json: @article, status: :created, location: @article
        }
      end
    else 
      respond_to do |format|
        format.html {
          render :edit, status: :unprocessable_entity
        }
        format.json { 
          render json: @article.errors, status: :unprocessable_entity
        }
      end
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html {
        redirect_to root_path, status: :see_other
      }
      format.json
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
