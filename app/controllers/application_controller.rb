class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :user_activity
    before_action :block_ip_addresses

    private

    def user_activity
        current_user.try :touch
    end

    protected

    def block_ip_addresses
        blocked_ips = []
        head :unauthorized if blocked_ips.include?(current_ip_address)
    end
  
    def current_ip_address
        request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
    end
end
