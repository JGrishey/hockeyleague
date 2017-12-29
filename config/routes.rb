Rails.application.routes.draw do
    mount_devise_token_auth_for 'User', at: 'auth'
    default_url_options protocol: :https

    scope module: :v1, constraints: ApiVersion.new('v1', true) do
        resources :leagues do
            resources :seasons do
                resources :teams do
                end
                resources :games do
                end
            end
        end
        resources :chat_boxes do
            resources :messages
        end
        get '/home', to: 'pages#home', as: 'home'
    end

    resources :notifactions

    mount ActionCable.server => '/cable'
end
