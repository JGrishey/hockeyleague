module V1
    class SubforumsController < ApplicationController
        before_action :set_subforum, only: [:update, :show, :destroy]

        # GET /subforums
        def index
            @subforums = Subforum.all.order('title ASC')
            json_response(@subforums)
        end

        # POST /subforums
        def create
            @subforum = Subforum.create!(subforum_params)
            json_response(@subforum, :created)
        end

        # PUT /subforums/:id
        def update
            @subforum.update(subforum_params)
            head :no_content
        end

        # DELETE /subforums/:id
        def destroy
            @subforum.destroy
            head :no_content
        end 

        # GET /subforums/:id
        def show
            json_response(@subforum)
        end

        private

        def subforum_params
            params.require(:subforum).permit(:title)
        end

        def set_subforum
            @subforum = Subforum.find(params[:id])
        end
    end
end