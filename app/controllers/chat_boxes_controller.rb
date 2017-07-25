class ChatBoxesController < ApplicationController

    def show
        @chatbox = ChatBox.includes(:messages).find_by(id: params[:id])
        @message = Message.new
    end

end