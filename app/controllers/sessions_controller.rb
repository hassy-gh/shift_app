class SessionsController < ApplicationController
  before_action :no_logged_in_user, only: [:new, :create]
  before_action :logged_in_user, only: :destroy
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        flash[:info] = "ログインしました"
        redirect_back_or @user
      else
        message = "アカウントが認証されていません。"
        message += "本登録メールに記載されたリンクをご確認ください"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:info] = "ログアウトしました"
    redirect_to root_url
  end
  
  private
  
    #beforeアクション
  
    # ログインしていないユーザーかどうか確認
    def no_logged_in_user
      if logged_in?
        flash[:danger] = "すでにログインしています。"
        redirect_to root_url
      end
    end
end
