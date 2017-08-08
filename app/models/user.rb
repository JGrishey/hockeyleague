class User < ApplicationRecord
    
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
    
    validates :email, presence: true
    validates :user_name, presence: true, length: { minimum: 3, maximum: 15 }

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :messages, dependent: :destroy

    has_many :owned_teams, :class_name => "Team", :foreign_key => "captain_id"

    has_many :game_players, dependent: :destroy
    has_many :games, :through => :game_players
    
    has_many :team_players, dependent: :destroy
    has_many :teams, :through => :team_players

    has_many :goals, :class_name => "Goal", :foreign_key => "scorer_id"
    has_many :primary_assists, :class_name => "Goal", :foreign_key => "primary_id"
    has_many :secondary_assists, :class_name => "Goal", :foreign_key => "secondary_id"
    has_many :penalties
    has_many :stat_lines

    has_attached_file :avatar
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

    def getSeasonStats (season)
        goals = 0
        assists = 0
        plus_minus = 0
        shots = 0
        fow = 0
        fot = 0
        hits = 0
        shots_against = 0
        goals_against = 0
        pim = 0
        games_played = 0

        self.goals.each do |goal|
            if goal.game.season == season
                goals += 1
            end
        end
        self.primary_assists.each do |pA|
            if pA.game.season == season
                assists += 1
            end
        end
        self.secondary_assists.each do |sA|
            if sA.game.season == season
                assists += 1
            end
        end
        self.penalties.each do |penalty|
            if penalty.game.season == season
                pim += penalty.duration
            end
        end
        self.stat_lines.each do |stats|
            if stats.game.season == season
                plus_minus += stats.plus_minus if stats.plus_minus
                shots += stats.shots if stats.shots
                fow += stats.fow if stats.fow
                fot += stats.fot if stats.fot
                hits += stats.hits if stats.hits
                shots_against += stats.shots_against if stats.shots_against
                goals_against += stats.goals_against if stats.goals_against
                games_played += 1
            end
        end
        return {
            'goals': goals,
            'assists': assists,
            'points': goals + assists,
            'plus_minus': plus_minus,
            'shots': shots,
            'SH%': shots > 0 ? (goals / shots) : 0,
            'fow': fow,
            'fot': fot,
            'FO%': fot > 0 ? (fow / fot) : 0,
            'hits': hits,
            'shots_against': shots_against,
            'goals_against': goals_against,
            'SV%': shots_against > 0 ? (goals_against / shots_against) : 0,
            'GAA': games_played > 0 ? (goals_against / games_played) : 0,
            'games_played': games_played
        }
    end
end
