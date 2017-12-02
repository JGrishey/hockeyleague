module V1
    class ProfilesController < ApplicationController
        before_action :set_user

        # GET /users/:id
        def show
            json_response(@user)
        end

        private

        def profile_params
            params.require(:user).permit(:born, :birthplace, :height, :weight, :banner, :avatar)
        end

        def set_user
            @user = User.find(params[:id])
        end
    end
end
