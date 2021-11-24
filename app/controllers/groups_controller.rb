class GroupsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  before_action :join_user, only: [:new, :create]
  before_action :admin_user, only: [:edit, :update]
  before_action :correct_group, only: [:edit, :update]
  before_action :get_group, only: [:edit, :update]
  
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
    if @group.update(group_params)
      flash[:success] = "変更を保存しました"
      redirect_to edit_group_path
    else
      render 'edit'
    end
  end
  
  private
  
    def group_params
      params.require(:group).permit(:name, :password, :password_confirmation)
    end
    
    # beforeアクション
    
    # 正しいグループかどうか確認
    def correct_group
      if current_user.group != Group.find(params[:id])
        flash[:danger] = "正しいグループではありません"
        redirect_to(current_user)
      end
    end
end
