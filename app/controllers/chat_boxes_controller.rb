class ChatBoxesController < ApplicationController

    def show
        @chatbox = ChatBox.includes(:messages).find_by(id: params[:id])
        @messages = @chatbox.messages.page params[:page]
        @message = Message.new
    end

end