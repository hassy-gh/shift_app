class JoininigsController < ApplicationController
  before_action :logged_in_user
  before_action :no_join_user, only: :update
  before_action :admin_user, only: :update
  before_action :join_user, only: [:new, :create]

  def new
  end
  
  def create
    @group = Group.find_by(name: params[:joining][:name])
    if @group && @group.authenticate(params[:joining][:password])
      if @group.users.find_by(employee_no: current_user.employee_no).nil?
        current_user.update_attribute(:group_id, @group.id)
        flash[:info] = "#{@group.name}に参加しました"
        redirect_to current_user
      else
        flash[:danger] = "同じ従業員Noがすでにグループに存在します"
        redirect_to join_path
      end
    else
      flash.now[:danger] = "グループ名またはパスワードが正しくありません"
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:format])
    @user.update_attribute(:group_id, nil)
    flash[:success] = "#{@user.name}をグループから削除しました"
    redirect_to users_path
  end
end
