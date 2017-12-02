class Api::NotificationsController < ApplicationController
    def link_through
        @notification = Notification.find(params[:id])
        @notification.update(read: true)
        redirect_to @notification.src, method: :get
    end

    def clear
        @notification = Notification.find(params[:id])
        @notification.update(read: true)
        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def clear_all
        current_user.notifications.where(read: false).each do |n|
            n.update(read: true)
        end
        respond_to do |format|
            format.html {}
            format.js
        end
    end
end