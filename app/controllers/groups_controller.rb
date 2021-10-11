class GroupsController < ApplicationController
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "グループを作成しました"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  private
  
    def group_params
      params.require(:group).permit(:name, :password, :password_confirmation)
    end
end
