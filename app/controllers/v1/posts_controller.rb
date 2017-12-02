module V1
    class PostsController < ApplicationController
        before_action :set_subforum
        before_action :get_post, only: [:show, :destroy, :update]

        # GET /subforums/:subforum_id/posts
        def index
            @posts = @subforum.posts.order('created_at DESC')
            json_response(@posts)
        end

        # GET /subforums/:subforum_id/posts/:id
        def show
            @post = @subforum.posts.find(params[:id])
            json_response(@post)
        end

        # POST /subforums/:subforum_id/posts
        def create
            @post = @subforums.posts.create!(post_params)
            json_response(@post, :created)
        end

        # PUT /subforums/:subforum_id/posts/:id
        def update
            @post.update(post_params)
            head :no_content
        end

        # DELETE /subforums/:subforum_id/posts/:id
        def destroy
            @post.destroy
            head :no_content
        end

        private

        def post_params
            params.require(:post).permit(:title, :content, :subforum_id)
        end

        def get_post
            @post = @subforum.posts.find(params[:id])
        end

        def set_subforum
            @subforum = Subforum.find(params[:subforum_id])
        end
    end
end
