module V1
    class CommentsController < ApplicationController
        before_action :set_subforum
        before_action :set_post
        before_action :set_comment, only: [:update, :show, :destroy]

        # GET /subforums/:subforum_id/posts/:post_id/comments
        def index
            @comments = @post.comments.order('created_at ASC')
            json_response(@comments)
        end

        # POST /subforums/:subforum_id/posts/:post_id/comments
        def create
            @comment = @post.comments.create!(comment_params)
            json_response(@comment, :created)
        end

        # PUT /subforums/:subforum_id/posts/:post_id/comments/:id
        def update
            @comment.update(comment_params)
            head :no_content
        end

        # GET /subforums/:subforum_id/posts/:post_id/comments/:id
        def show
            json_response(@comment)
        end

        # DELETE /subforums/:subforum_id/posts/:post_id/comments/:id
        def destroy
            @comment.destroy
            head :no_content
        end

        private

        def set_comment
            @comment = @post.comments.find(params[:id])
        end

        def set_post
            @post = @subforum.posts.find(params[:post_id])
        end
        
        def comment_params
            params.require(:comment).permit(:content)
        end

        def set_subforum
            @subforum = Subforum.find(params[:subforum_id])
        end
    end
end
