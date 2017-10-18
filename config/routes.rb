Rails.application.routes.draw do
    default_url_options protocol: :https
    get 'profiles/show'
    get 'pages/rules'
    get 'pages/landing'
    get 'pages/player_rankings'
    get 'pages/draft'
    get 'pages/draftupdate'
    get 'pages/protected_players'
    get 'chat_boxes/:id/archive', to: "chat_boxes#archive", as: :archive
    get 'chat_boxes/timestamps'

    devise_for :users, :controllers => {registrations: 'registrations', sessions: 'sessions'}
    
    root to: "pages#landing"

    resources :subforums do
        resources :posts do
                member do
                    get 'like'
                    get 'dislike'
                end
            resources :comments do
                member do
                    get 'like'
                    get 'dislike'
                end
            end
        end
    end

    resources :leagues do
        resources :seasons do
            resources :teams do
                member do
                    get 'schedule'
                end
            end
            resources :games do
                member do
                    get 'enter_home_stats'
                    get 'enter_away_stats'
                    get 'submit_home_players'
                    get 'submit_away_players'
                    post 'process_home_stats'
                    post 'process_away_stats'
                    post 'add_players'
                    post 'make_final'
                end
            end
            member do
                get 'upload'
                get 'players'
                get 'leaders'
                get 'schedule'
                get 'rosters'
                get 'signup'
                get 'signups'
                get 'transactions'
                get 'submit_transaction'
                post 'process_transaction'
                post 'approve_transaction'
                post 'decline_transaction'
                post 'process_signup'
                post 'process_file'
            end
        end
        member do
            get 'players'
            get 'leaders'
            get 'schedule'
            get 'history'
            get 'signups'
            get 'rosters'
            get 'transactions'
        end
    end

    mount ActionCable.server => '/cable'
    
    resources :chat_boxes

    get ':user_name', to: 'profiles#show', as: :profile
    get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
    patch ':user_name/edit', to: 'profiles#update', as: :update_profile
    get ':user_name/post_history', to: "profiles#post_history", as: :post_history

    get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
    post 'notifications/:id/clear', to: "notifications#clear", as: :clear_notification
    post 'notifications/clear_all', to: "notifications#clear_all", as: :clear_all

end
