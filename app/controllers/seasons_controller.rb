class SeasonsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_league
    before_action :set_season, only: [:show, :destroy, :upload, :process_file, :standings]
    

    def index
        @seasons = @league.seasons.order('created_at DESC')
    end

    def new
        @season = @league.seasons.build
    end

    def create
        @season = @league.seasons.build(season_params)

        if @season.save
            flash[:success] = "Your season has been created!"
            redirect_to league_season_path(@league, @season)
        else
            flash[:error] = "Your season couldn't be created. Check the form."
            render :new
        end
    end

    def edit
        @season = @league.seasons.find(params[:id])
    end

    def update
        @season = @league.seasons.find(params[:id])
        if @season.update(season_params)
            flash[:success] = "Your season has been updated!"
            redirect_to league_season_path(@league, @season)
        else
            flash[:error] = "Your season couldn't be updated. Check the form."
            render :edit
        end
    end

    def show
    end

    def destroy
        @season.destroy
        flash[:success] = "Your season has been deleted."
        redirect_to root_path
    end

    def upload
    end

    def process_file
        uploaded_schedule = params[:season][:schedule].read
        data = JSON.parse(uploaded_schedule)

        # Clear existing data
        @season.games.each do |game|
            game.destroy
        end
        @season.teams.each do |team|
            team.destroy
        end


        data["teams"].each do |team|
            temp_team = @season.teams.build(name: team, captain_id: current_user.id)
            temp_team.save
        end

        data["games"].each do |game|
           temp_game = @season.games.build(away_id: @season.teams.find_by(name: game["away"]).id, home_id: @season.teams.find_by(name: game["home"]).id, date: DateTime.strptime(game["date"], "%m-%d-%Y %I:%M %p"))
           temp_game.save
        end

        redirect_to league_season_path(@league, @season)
    end

    def standings
    end
    
    private

    def season_params
        params.require(:season).permit(:title)
    end

    def set_season
        @season = @league.seasons.find(params[:id])
    end

    def set_league
        @league = League.find(params[:league_id])
    end
end