class ChatBoxesController < ApplicationController
    def archive
        @chatbox = ChatBox.find(params[:id])
    end
end