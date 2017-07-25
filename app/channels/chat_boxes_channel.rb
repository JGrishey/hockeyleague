class ChatBoxesChannel < ApplicationCable::Channel
    def subscribed
        stream_from "chat_boxes_#{params['chat_box_id']}_channel"
    end

    def unsubscribed
    end

    def send_message (data)
        current_user.messages.create!(body: data['message'], chat_box_id: data['chat_box_id'])
    end
end