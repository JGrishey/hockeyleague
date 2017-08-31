class SubforumsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_subforum, only: [:edit, :update, :show, :destroy]

    def index
        @subforums = Subforum.all.order('title DESC')
        @leagues = League.all.order('name ASC')
        @recent_posts = Post.order('updated_at DESC').first(5)
    end

    def new
        @subforum = Subforum.new
    end

    def create
        @subforum = Subforum.new(subforum_params)

        if @subforum.save
            flash[:success] = "Your subforum has been created. Make a new post in it now!"
            redirect_to @subforum, method: :get
        else
            flash[:error] = "Your subforum couldn't be created. Check the form."
            render :new
        end
    end

    def edit
    end

    def update
        if @subforum.update(subforum_params)
            flash[:success] = "Your subforum has been updated."
            redirect_to @subforum, method: :get
        else
            flash[:error] = "Your subforum couldn't be updated. Check the form."
            render :edit
        end
    end

    def destroy
        @subforum.destroy
        flash[:success] = "Your subforum has been deleted."
        redirect_to root_path
    end 

    def show
        @subforum = Subforum.find(params[:id])
        @posts = @subforum.posts
    end

    private

    def subforum_params
        params.require(:subforum).permit(:title)
    end

    def set_subforum
        @subforum = Subforum.find(params[:id])
    end

end