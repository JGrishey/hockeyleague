class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Response
    include ExceptionHandler

    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    end
end
