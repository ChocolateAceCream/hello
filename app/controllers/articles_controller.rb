class ArticlesController < ApplicationController

    http_basic_authenticate_with name: "di", password: "di880817", except: [:index, :show]

    def index
             @articles = Article.all
    end

    def show
        @articles = Article.all
        redirect_to articles_path
    end

    def display
        @article = Article.find(params[:id])
    end
    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
          @article = Article.new(article_params)
          ModelMailer.new_record_notification.deliver
          if  @article.save
              redirect_to @article
          else
              render 'new'
          end
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article=Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
    end

    private
    def article_params
              params.require(:article).permit(:title, :text)
    end
end
