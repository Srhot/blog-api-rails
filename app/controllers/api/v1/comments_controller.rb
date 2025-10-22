module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: [:show, :update, :destroy]
      before_action :set_post, only: [:index, :create]

      # GET /api/v1/comments/:id
      def show
        render json: @comment, include: [:user, :post]
      end

      # GET /api/v1/posts/:post_id/comments
      # GET /api/v1/users/:user_id/comments
      def index
        if params[:post_id]
          @comments = @post.comments
        elsif params[:user_id]
          @comments = User.find(params[:user_id]).comments
        end
        render json: @comments, include: [:user, :post]
      end

      # POST /api/v1/posts/:post_id/comments
      def create
        @comment = @post.comments.new(comment_params)

        if @comment.save
          render json: @comment, status: :created, include: [:user, :post]
        else
          render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/comments/:id
      def update
        if @comment.update(comment_params)
          render json: @comment, include: [:user, :post]
        else
          render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/comments/:id
      def destroy
        @comment.destroy
        head :no_content
      end

      private

      def set_comment
        @comment = Comment.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Comment not found' }, status: :not_found
      end

      def set_post
        @post = Post.find(params[:post_id]) if params[:post_id]
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
      end

      def comment_params
        params.require(:comment).permit(:content, :user_id)
      end
    end
  end
end