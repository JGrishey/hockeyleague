class PostsController < ApplicationController

    before_action :authenticate_user!
    before_action :get_post, only: [:show, :destroy]
    before_action :set_subforum

    def index
        @posts = Post.all
    end

    def show
    end

    def new
        @post = @subforum.posts.build
    end

    def create
        @post = @subforum.posts.build(post_params)
        @post.user_id = current_user.id

        if @post.save
            flash[:success] = "Your post has been created."
            redirect_to subforum_post_path(@subforum, @post), method: :get
        else
            flash[:error] = "Something went wrong. Check the form."
            render :new
        end
    end

    def edit
        @post = @subforum.posts.find_by(id: params[:id])
    end

    def update
        @post = @subforum.posts.find_by(id: params[:id])
        if @post.update(post_params)
            flash[:success] = "Your post has been updated."
            redirect_to subforum_post_path(@subforum, @post), method: :get
        else
            flash[:error] = "Something went wrong. Check the form."
            render :edit
        end
    end

    def destroy
        @post.destroy
        flash[:success] = "Your post has been deleted."
        redirect_to root_path
    end

    private

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