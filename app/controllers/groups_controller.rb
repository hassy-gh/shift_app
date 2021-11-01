class GroupsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :no_join_user, only: [:new, :create]
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.update_columns(group_id: @group.id, admin: true)
      flash[:success] = "グループを作成しました"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  private
  
    def group_params
      params.require(:group).permit(:name, :password, :password_confirmation)
    end
end
