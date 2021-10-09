class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private
  
    #beforeアクション
  
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインが必要です。"
        redirect_to login_url
      end
    end
    
    # 管理者かどうか確認
    def admin_user
      unless current_user.admin?
        flash[:danger] = "管理者用のページです"
        redirect_to(root_url) 
      end
    end
end
