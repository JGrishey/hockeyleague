Rails.application.routes.draw do
    get 'profiles/show'

    devise_for :users, :controllers => {registrations: 'registrations'}
    
    root to: "subforums#index"

    resources :subforums do
        resources :posts do
            resources :comments
        end
    end

    resources :leagues do
        resources :seasons do
            resources :teams
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
                get 'standings'
                post 'process_file'
            end
        end
    end

    mount ActionCable.server => '/cable'
    
    resources :chat_boxes

    get ':user_name', to: 'profiles#show', as: :profile
    get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
    patch ':user_name/edit', to: 'profiles#update', as: :update_profile
end
