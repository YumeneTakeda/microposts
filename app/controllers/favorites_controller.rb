class FavoritesController < ApplicationController
  def create
    
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = "ツイートをいいねしました。"
    redirect_back(fallback_location: "/")  
    end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = "いいねを解除しました。"
    redirect_back(fallback_location: "/")  
  end
end
