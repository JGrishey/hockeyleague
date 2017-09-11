class PagesController < ApplicationController
    
    def rules
    end

    def landing
        if user_signed_in?
            redirect_to subforums_path
        end
    end

end