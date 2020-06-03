class FavoritesController < ApplicationController
  def index
    if logged_in?
      @micropost = current_user.microposts.build
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
    end
  end
  
  def create
    
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = "ツイートをいいねしました。"
    redirect_to root_url
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = "いいねを解除しました。"
    redirect_to root_url
  end
end
