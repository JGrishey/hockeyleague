module V1
    class NotificationsController < ApplicationController
        before_action :set_notification

        # GET /notifications
        def index
            @notifications = Notification.all.order('created_at DESC')
            json_response(@notifications)
        end

        # GET /notifications/:id
        def show
            json_response(@notification)
        end

        # POST /notifications
        def create
            @notification = Notification.create!(notification_params)
            json_response(@notification, :created)
        end

        # PUT /notifications/:id
        def update
            @notification.update(notification_params)
            head :no_content
        end

        # DELETE /notifications/:id
        def destroy
            @notification.destroy
            head :no_content
        end

        private

        def set_notification
            @notification = Notification.find(params[:id])
        end

        def notification_params
            params.require(:notification).permit(:body, :user_id)
        end
    end
end
