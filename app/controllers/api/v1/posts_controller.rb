module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy, :add_tag, :remove_tag]

      # GET /api/v1/posts
      # GET /api/v1/users/:user_id/posts
      # GET /api/v1/categories/:category_id/posts
      def index
        if params[:user_id]
          @posts = User.find(params[:user_id]).posts
        elsif params[:category_id]
          @posts = Category.find(params[:category_id]).posts
        else
          @posts = Post.all
        end
        render json: @posts, include: [:user, :category, :tags]
      end

      # GET /api/v1/posts/:id
      def show
        render json: @post, include: [:user, :category, :comments, :tags]
      end

      # POST /api/v1/posts
      def create
        @post = Post.new(post_params)

        if @post.save
          render json: @post, status: :created, include: [:user, :category, :tags]
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/posts/:id
      def update
        if @post.update(post_params)
          render json: @post, include: [:user, :category, :tags]
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/posts/:id
      def destroy
        @post.destroy
        head :no_content
      end

      # POST /api/v1/posts/:id/add_tag
      def add_tag
        tag = Tag.find_by(id: params[:tag_id])
        if tag && !@post.tags.include?(tag)
          @post.tags << tag
          render json: @post, include: :tags
        else
          render json: { error: 'Tag not found or already added' }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/posts/:id/remove_tag
      def remove_tag
        tag = Tag.find_by(id: params[:tag_id])
        if tag && @post.tags.include?(tag)
          @post.tags.delete(tag)
          render json: @post, include: :tags
        else
          render json: { error: 'Tag not found or not associated' }, status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
      end

      def post_params
        params.require(:post).permit(:title, :content, :published, :user_id, :category_id)
      end
    end
  end
end