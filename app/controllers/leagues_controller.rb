class LeaguesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_league, only: [:edit, :update, :show, :destroy]

    def index
        @leagues = League.all.order('name DESC')
    end

    def new
        @league = League.new
    end

    def create
        @league = League.new(league_params)

        if @league.save
            flash[:success] = "Your league has been created!"
            redirect_to @league
        else
            flash[:error] = "Your league couldn't be created. Please check the form."
            render :new
        end
    end

    def edit
    end

    def update
        if @league.update(league_params)
            flash[:success] = "Your league has been updated!"
            redirect_to @league
        else
            flash[:error] = "Your league couldn't be updated. Please check the form."
            render :edit
        end
    end

    def show
    end

    def destroy
        @league.destroy
        flash[:success] = "Your league was deleted."
        redirect_to root_path
    end

    private

    def league_params
        params.require(:league).permit(:name)
    end

    def set_league
        @league = League.find(params[:id])
    end
end