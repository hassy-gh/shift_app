class JoininigsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  # before_action :employee_no_uniqueness, only: :create
  
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
  
  def destroy
  end
  
  private
  
    def employee_no_uniqueness
      @group = Group.find_by(name: params[:joining][:name])
      unless @group.users.find_by(employee_no: current_user.employee_no).nil?
        flash[:danger] = "同じ従業員Noがすでにグループに存在します"
        redirect_to join_path
      end
    end
end
