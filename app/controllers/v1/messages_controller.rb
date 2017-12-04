module V1
    class MessagesController < ApplicationController
        before_action :set_chatbox
        before_action :set_message, only: [:show, :update, :destroy]

        # GET /chat_boxes/:chat_box_id/messages
        def index
            @messages = @chatbox.messages
            json_response(@messages)
        end

        # GET /chat_boxes/:chat_box_id/messages/:id
        def show
            json_response(@message)
        end

        # PUT /chat_boxes/:chat_box_id/messages/:id
        def update
            @message.update(message_params)
            head :no_content
        end

        # POST /chat_boxes/:chat_box_id/messages
        def create
            @message = @chatbox.messages.create!(message_params)
            json_response(@message, :created)
        end

        # DELETE /chat_boxes/:chat_box_id/messages/:id
        def destroy
            @message.destroy
            head :no_content
        end

        private

        def message_params
            params.require(:message).permit(:body, :user_id)
        end

        def set_chatbox
            @chatbox = ChatBox.find(params[:chat_box_id])
        end

        def set_message
            @message = @chatbox.messages.find(params[:id])
        end
    end
end