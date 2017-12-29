module V1
    class PagesController < ApplicationController
        # /home
        def home
            # All leagues
            @leagues = League.all

            # Get main league
            @main_league = @leagues.first

            # Get recent games
            @games = @main_league.current_season.games.where(final: true).order('date DESC').first(5)

            json_response({
                'leagues': @leagues,
                'main_league': @main_league,
                'recent_games': @games
            })
        end
    end
end
