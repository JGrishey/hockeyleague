module V1
    class ChatBoxesController < ApplicationController
        # GET /chatboxes/:id
        def show
            @chatbox = ChatBox.find(params[:id])
            json_response(@chatbox)
        end
    end
end
