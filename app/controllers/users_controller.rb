class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :favoritings, :favorites]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
    @user = User.find(session[:user_id])

  end

  def show
    
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  def favoritings
    @micropost = Micropost.find(params[:id])
    @favoritings = @user.favoritings.page(params[:page])
    counts(@micropost)
  end
  
  def favorites
    @micropost = Micropost.find(params[:id])
    @favorites = @micropost.favorites.page(params[:page])
    counts(@micropost)
  end

  def likes
    if logged_in?
      @microposts = Micropost.all.page(params[:page]) #current_user.feed_microposts.order(id: :desc).page(params[:page])
      
      @user = User.find(params[:id])
      counts(@user)
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
