class Api::ChatBoxesController < ApplicationController
    def archive
        @chatbox = ChatBox.find(params[:id])
        @messages = @chatbox.messages.order('created_at DESC').page(params[:page])
    end

    def timestamps
        @chatbox = ChatBox.first
        respond_to do |format|
            format.js
        end
    end
end