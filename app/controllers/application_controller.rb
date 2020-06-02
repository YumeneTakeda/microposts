class ApplicationController < ActionController::Base
    
    include SessionsHelper
    
    private

    def require_user_logged_in
        unless logged_in?
          redirect_to login_url
        end
    end
    
    def counts(user)
        @cout_microposts = user.microposts.count
        @count_followings = user.followings.count
        @count_followers = user.followers.count
        @count_favoritings = user.favoritings.count
        @count_favorites = user.favorites.count
    end
end
