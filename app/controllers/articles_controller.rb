class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # Create a new article in Memory (RAM)
    @article = Article.new(article_params)
    # Save to database, making it persistent
    if @article.save
      # Redirect to the 'show' action for @article
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    # Pull the existing article out of the database
    @article = Article.find(params[:id])

    # Try updating the article params that came from the web form
    if @article.update(article_params)
      # Redirect to the 'show' action for @article
      redirect_to @article
    else
      # Just render the edit view, without calling the edit action
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
