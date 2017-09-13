class SessionsController < Devise::SessionsController
    skip_before_filter :verify_authenticity_token
      def create
        params[:user].merge!(remember_me: 1)
        super
      end
    
end