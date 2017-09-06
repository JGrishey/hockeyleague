class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_subforum

    def index
        @comments = @post.comments.order('created_at ASC')

        respond_to do |format|
            format.html { render layout: !request.xhr? }
        end
    end

    def create
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id 

        if @comment.save
            respond_to do |format|
                format.html { redirect_to root_path }
                format.js
            end
            create_notification(
                "#{@comment.user.user_name} commented on your post.",
                @comment.user,
                subforum_post_path(@subforum, @post)
            )
            User.find_by(user_name: "Admin").messages.create!(
                body: "#{view_context.link_to(current_user.user_name, profile_path(current_user.user_name))} replied to \"#{view_context.link_to(@post.title, subforum_post_path(@subforum, @post))}\" in #{@subforum.title}.",
                chat_box_id: ChatBox.first.id)
        else
            flash[:alert] = "Check the comment form, something went wrong!"
            render root_path
        end
    end

    def edit
        @comment = @post.comments.find(params[:id])
    end

    def update
        @comment = @post.comments.find(params[:id])
        if @comment.update(comment_params)
            redirect_to subforum_post_path(@subforum, @post)
        else
            render :edit
        end
    end

    def show
        @comment = @post.comments.find(params[:id])
        respond_to do |format|
            format.js
        end
    end

    def destroy
        @comment = @post.comments.find(params[:id])

        if @comment.user_id == current_user.id
            @comment.destroy
            respond_to do |format|
                format.html { redirect_to post_path(@post) }
                format.js
            end
        end
    end

    def like
        @comment = @post.comments.find(params[:id])
        if @comment.liked_by current_user
            create_notification(
                "Your comment was liked by #{current_user.user_name}.",
                @comment.user,
                subforum_post_path(@subforum, @post)
            )
            respond_to do |format|
                format.html { redirect_to :back }
                format.js
            end
        end
    end

    def dislike
        @comment = @post.comments.find(params[:id])
        if @comment.unliked_by current_user
            respond_to do |format|
                format.html { redirect_to :back }
                format.js
            end
        end
    end

    private

    def create_notification (body, user, src)
        notification = user.notifications.create!(
            body: body,
            src: src
        )
    end

    def set_post
        @post = Post.find(params[:post_id])
    end
    
    def comment_params
        params.require(:comment).permit(:content)
    end

    def set_subforum
        @subforum = Subforum.find(params[:subforum_id])
    end

end