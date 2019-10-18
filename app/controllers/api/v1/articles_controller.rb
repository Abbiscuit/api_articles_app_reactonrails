module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        articles = Article.all.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded Articles', data: articles }, status: :ok
      end

      def show
        article = Article.find_by(id: params[:id])
        render json: { status: 'SUCCESS', message: 'Loaded Article', data: article }, status: :ok
      end

      def create
        article = Article.new(article_params)
        if article.save
          render json: { status: 'SUCCESS', message: 'Saved Article', data: article }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Article not saved', data: article.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        article = Article.find_by(id: params[:id])
        article.destroy
        render json: { status: 'SUCCESS', message: 'Article deleted', data: article }, status: :ok
      end

      def update
        article = Article.find_by(id: params[:id])

        if article.update_attributes(article_params)
          render json: { status: 'SUCCESS', message: 'Article updated', data: article }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Article not updated', data: article.errors }, status: :unprocessable_entity
        end
      end

      private
        def article_params
          params.require(:article).permit(:title, :body)
        end
    end
  end
end