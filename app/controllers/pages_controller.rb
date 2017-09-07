class PagesController < ApplicationController
    before_action :authenticate_user!
    
    def rules
    end
end