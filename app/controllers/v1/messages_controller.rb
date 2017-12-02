class Api::MessagesController < ApplicationController
    def index
        @messages = ChatBox.find(params[:chat_box_id]).messages.last(25)
    end
end