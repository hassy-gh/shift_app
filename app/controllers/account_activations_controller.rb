class AccountActivationsController < ApplicationController
  
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "本登録が完了しました"
      redirect_to selection_path
    elsif user.activated?
      flash[:danger] = "すでに登録が完了しています"
      redirect_to user
    else
      flash[:danger] = "本登録用のリンクが有効ではありません"
      redirect_to root_url
    end
  end
end
