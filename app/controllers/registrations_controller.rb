class RegistrationsController < Devise::RegistrationsController
    skip_before_filter :verify_authenticity_token

    private

    def sign_up_params
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :current_password)
    end
    
end