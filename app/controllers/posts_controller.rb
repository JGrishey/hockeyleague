class PostsController < ApplicationController

    before_action :authenticate_user!
    before_action :get_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end

    def show
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            flash[:success] = "Your post has been created."
            redirect_to @post, method: :get
        else
            flash[:error] = "Something went wrong. Check the form."
            render :new
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            flash[:success] = "Your post has been updated."
            redirect_to @post, method: :get
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
        params.require(:post).permit(:title, :content)
    end

    def get_post
        @post = Post.find(params[:id])
    end

end