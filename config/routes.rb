Rails.application.routes.draw do
    default_url_options protocol: :https
    devise_for :users, :controllers => {registrations: 'registrations', sessions: 'sessions'}
    
    root to: "pages#home"

    namespace :api, defaults: { format: :json } do
        resources :leagues do
            resources :seasons do
                resources :teams do
                end
                resources :games do
                end
            end
        end
        resources :chat_boxes
    end

    ##
    # resources :subforums do
    #     resources :posts do
    #             member do
    #                 get 'like'
    #                 get 'dislike'
    #             end
    #         resources :comments do
    #             member do
    #                 get 'like'
    #                 get 'dislike'
    #             end
    #         end
    #     end
    # end

    # resources :leagues do
    #     resources :seasons do
    #         resources :teams do
    #             member do
    #                 get 'schedule'
    #             end
    #         end
    #         resources :games do
    #             member do
    #                 # Manual
    #                 get 'enter_home_stats'
    #                 get 'enter_away_stats'
    #                 get 'submit_home_players'
    #                 get 'submit_away_players'
    #                 post 'process_home_stats'
    #                 post 'process_away_stats'

    #                 # Image inputting
    #                 get 'enter_team_stats'
    #                 post 'process_team_stats'
    #                 get 'enter_home_image'
    #                 get 'enter_home_player_names'
    #                 post 'process_home_image'
    #                 post 'process_home_names'
    #                 get 'enter_away_image'
    #                 get 'enter_away_player_names'
    #                 post 'process_away_image'
    #                 post 'process_away_names'

    #                 post 'add_players'
    #                 post 'make_final'
    #             end
    #         end
    #         member do
    #             get 'upload'
    #             get 'players'
    #             get 'leaders'
    #             get 'schedule'
    #             get 'rosters'
    #             get 'signup'
    #             get 'signups'
    #             get 'transactions'
    #             get 'submit_transaction'
    #             post 'process_transaction'
    #             post 'approve_transaction'
    #             post 'decline_transaction'
    #             post 'process_signup'
    #             post 'process_file'
    #         end
    #     end
    #     member do
    #         get 'players'
    #         get 'leaders'
    #         get 'schedule'
    #         get 'history'
    #         get 'signups'
    #         get 'rosters'
    #         get 'transactions'
    #     end
    # end
    ##

    mount ActionCable.server => '/cable'
end
