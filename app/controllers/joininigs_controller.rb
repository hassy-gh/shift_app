class JoininigsController < ApplicationController
  
  def new
  end
  
  def create
    @group = Group.find_by(name: params[:joining][:name])
    if @group && @group.authenticate(params[:joining][:password]) && @group.users.find_by(employee_no: current_user.employee_no).nil?
      current_user.update_attribute(:group_id, @group.id)
      flash[:info] = "#{@group.name}に参加しました"
      redirect_to current_user
    else
      flash.now[:danger] = "グループ名またはパスワードが正しくありません"
      render 'new'
    end
  end
  
  def destroy
  end
end
