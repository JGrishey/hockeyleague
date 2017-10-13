require 'csv'

class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:player_rankings]
    
    def rules
    end

    def landing
        if user_signed_in?
            redirect_to subforums_path
        end
    end

    def player_rankings
        raw_ratings = CSV.parse(open("https://raw.githubusercontent.com/JGrishey/mhlratings/master/rankings.csv") {|f| f.read })

        @ratings = []

        raw_known = raw_ratings.select {|x| x[1] != "?"}

        maxrating = raw_known.max_by { |p| p[1].to_f }
        minrating = raw_known.max_by { |p| -p[1].to_f}

        raw_ratings.each do |(player, rating)|
            puts player
            if rating === "?"
                @ratings.push({'user_name': player, 'user_avatar': User.all.find_by(user_name: player) ? User.all.find_by(user_name: player).get_avatar : "nil", 'rating': 0.00, 'norm_rating': (0.00 - minrating[1].to_f) / (maxrating[1].to_f - minrating[1].to_f)})
            else
                @ratings.push({'user_name': player, 'user_avatar': User.all.find_by(user_name: player) ? User.all.find_by(user_name: player).get_avatar : "nil", 'rating': rating.to_f / 100.0, 'norm_rating': (rating.to_f - minrating[1].to_f) / (maxrating[1].to_f - minrating[1].to_f)})
            end
        end

        @ratings = @ratings.sort_by {|p| -p[:rating].to_f }
    end

    def protected_players

    end

    def draft
        @season = Season.first
        @teams = @season.teams.includes(:team_players)
        @unplaced = @season.signups.select{|s| s.player.getCurrentTeamPlayer(@season).team.name == "Unplaced Players"}.sort_by{|s| s.player.user_name}
    end

    def draft_update
        @season = Season.first
        @teams = @season.teams.includes(:team_players)
        @unplaced = @season.signups.select{|s| s.player.getCurrentTeamPlayer(@season).team.name == "Unplaced Players"}.sort_by{|s| s.player.user_name}
    end
end