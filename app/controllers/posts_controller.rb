class PostsController < ApplicationController

    before_action :authenticate_user!
    before_action :get_post, only: [:show, :destroy, :like, :dislike]
    before_action :set_subforum

    def index
        @posts = Post.all
    end

    def show
        @comments = @post.comments.order('created_at ASC').page(params[:page])
    end

    def new
        @post = @subforum.posts.build
    end

    def create
        @post = @subforum.posts.build(post_params)
        @post.user_id = current_user.id

        if @post.save
            flash[:success] = "Your post has been created."
            User.find_by(user_name: "Admin").messages.create!(
                body: "#{view_context.link_to(current_user.user_name, profile_path(current_user.user_name))} started \"#{view_context.link_to(@post.title, subforum_post_path(@subforum, @post))}\" in #{@subforum.title}.",
                chat_box_id: ChatBox.first.id)
            redirect_to subforum_post_path(@subforum, @post), method: :get
        else
            flash[:error] = "Something went wrong. Check the form."
            render :new
        end
    end

    def edit
        @post = @subforum.posts.find_by(id: params[:id])
        if current_user != @post.user && !current_user.admin
            redirect_to root_path
            flash[:alert] = "That's not your post!"
        end
    end

    def update
        @post = @subforum.posts.find_by(id: params[:id])
        if current_user != @post.user && !current_user.admin
            redirect_to root_path
            flash[:alert] = "That's not your post!"
        end
        if @post.update(post_params)
            flash[:success] = "Your post has been updated."
            redirect_to subforum_post_path(@subforum, @post), method: :get
        else
            flash[:error] = "Something went wrong. Check the form."
            render :edit
        end
    end

    def destroy
        if current_user != @post.user && !current_user.admin
            redirect_to root_path
            flash[:alert] = "That's not your post!"
        end
        @post.destroy
        flash[:success] = "Your post has been deleted."
        redirect_to root_path
    end

    def like
        if @post.liked_by current_user
            create_notification(
                "Your post was liked by #{current_user.user_name}.",
                @post.user,
                subforum_post_path(@subforum, @post)
            )
            respond_to do |format|
                format.html { redirect_to :back }
                format.js
            end
        end
    end

    def dislike
        if @post.unliked_by current_user
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

    def post_params
        params.require(:post).permit(:title, :content, :subforum_id)
    end

    def get_post
        @post = Post.find(params[:id])
    end

    def set_subforum
        @subforum = Subforum.find(params[:subforum_id])
    end

end