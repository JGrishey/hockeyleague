module V1
    class LeaguesController < ApplicationController
        before_action :set_league, except: [:new, :create, :index]
        before_action :set_games, except: [:new, :create, :index]

        # GET /leagues	
        def index
            @leagues = League.all.order('name DESC')
            json_response(@leagues)
        end

        # POST /leagues
        def create
            @league = League.create!(league_params)
            json_response(@league)
        end

        # PUT /leagues/:id
        def update
            @league.update(league_params)
            head :no_content
        end

        # GET /leagues/:id
        def show
            json_response(@league)
        end
        
        # DELETE /leagues/:id
        def destroy
            @league.destroy
            head :no_content
        end

        private

        def league_params
            params.require(:league).permit(:name)
        end

        def set_league
            @league = League.find(params[:id])
        end
    end
end
