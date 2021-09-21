class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(employee_no: params[:session][:employee_no])
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:info] = "ログインしました"
      redirect_to user
    else
      flash.now[:danger] = "従業員Noまたはパスワードが正しくありません"
      render 'new'
    end
  end
  
  def destroy
    log_out
    flash[:info] = "ログアウトしました"
    redirect_to root_url
  end
end
