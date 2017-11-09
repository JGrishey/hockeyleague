class Api::SubforumsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_subforum, only: [:edit, :update, :show, :destroy]

    def index
        @subforums = Subforum.all.order('title ASC')
        @leagues = League.all.order('name ASC')
        @recent_posts = Post.order('updated_at DESC').first(5)
        @chatbox = ChatBox.first
        @messages = @chatbox.messages.order('created_at ASC').last(25)
        @main_league = @leagues.first
        @season = @main_league.current_season
        @recent_games = @season.games
            .where(date: 1.week.ago..1.week.from_now)
            .order('date ASC')
            .group_by{
                |g| 
                    g.date.strftime("%^a %^b %d")
            }
            .to_a
            .map{ 
                |x| 
                    [
                        x[0], 
                        x[1].group_by{|g| g.teams}.to_a
                    ]
            }
        respond_to do |format|
            format.html
            format.js
        end
    end

    def new
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @subforum = Subforum.new
    end

    def create
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
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
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
    end

    def update
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        if @subforum.update(subforum_params)
            flash[:success] = "Your subforum has been updated."
            redirect_to @subforum, method: :get
        else
            flash[:error] = "Your subforum couldn't be updated. Check the form."
            render :edit
        end
    end

    def destroy
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @subforum.destroy
        flash[:success] = "Your subforum has been deleted."
        redirect_to root_path
    end 

    def show
        @subforum = Subforum.find(params[:id])
        @posts = @subforum.posts.order('created_at DESC').page(params[:page])
    end

    private

    def subforum_params
        params.require(:subforum).permit(:title)
    end

    def set_subforum
        @subforum = Subforum.find(params[:id])
    end

end