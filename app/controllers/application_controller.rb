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
        flash[:danger] = "管理者専用です"
        redirect_to(root_url) 
      end
    end
    
    # ユーザーを取得する
    def get_user
      @user = User.find(params[:id])
    end
    
    # グループを取得する
    def get_group
      @group = Group.find(current_user.group_id)
    end
    
    # 希望シフトを取得する
    def get_hope_shift
      @hope_shift = HopeShift.find(params[:id])
    end
    
    # 確定シフトを取得する
    def get_fixed_shift
      @fixed_shift = FixedShift.find(params[:id])
    end
    
    # グループに参加していないか確認する
    def no_join_user
      unless current_user.group.nil?
        flash[:danger] = "すでにグループに参加しています"
        redirect_to root_url
      end
    end
end
