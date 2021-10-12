class JoininigsController < ApplicationController
  
  def new
  end
  
  def create
    @group = Group.find_by(name: params[:joining][:name])
    @user = current_user
    if @group && @group.authenticate(params[:joininig][:password])
      @user.update_attribute(:group_id, @group.id)
      flash[:info] = "#{@group.name}に参加しました"
      redirect_to @user
    else
      flash.now[:danger] = "グループ名またはパスワードが正しくありません"
      render 'new'
    end
  end
  
  def destroy
  end
end
