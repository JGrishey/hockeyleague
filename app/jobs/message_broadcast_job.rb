class MessageBroadcastJob < ApplicationJob
    include ActionView::Helpers::DateHelper
    queue_as :default

    def perform (message)
        ActionCable.server.broadcast "chat_boxes_#{message.chat_box_id}_channel", message: message.body, author: message.user.user_name, id: message.id, time: time_ago_in_words(message.created_at)
    end
end