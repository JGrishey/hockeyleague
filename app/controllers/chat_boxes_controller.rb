class ChatBoxesController < ApplicationController
    def archive
        @chatbox = ChatBox.find(params[:id])
    end

    def timestamps
        @chatbox = ChatBox.first
        respond_to do |format|
            format.js
        end
    end
end