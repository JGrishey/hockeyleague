class NotificationsController < ApplicationController
    def link_through
        @notification = Notification.find(params[:id])
        @notification.update(read: true)
        redirect_to @notification.src, method: :get
    end
end