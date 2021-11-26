class JoiningsController < ApplicationController
  before_action :logged_in_user
  before_action :no_join_user, only: :update
  before_action :correct_user, only: :update, unless: -> { current_user.admin? }
  before_action :join_user, only: [:new, :create]

  def new
  end
  
  def create
    @group = Group.find_by(name: params[:joining][:name])
    if @group && @group.authenticate(params[:joining][:password])
      if @group.users.find_by(employee_no: current_user.employee_no).nil?
        current_user.update_columns(group_id: @group.id, join_group: true)
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
    @user.update_columns(group_id: nil, join_group: false)
    # @user.hope_shifts
    # @user.fixed_shifts
    if current_user.admin?
      flash[:success] = "#{@user.name}を退会させました"
      redirect_to users_path
    else
      flash[:success] = "退会しました"
      redirect_to root_url
    end
  end
  
  private
  
    # beforeアクション
    def correct_user
      unless current_user?(current_user)
        flash[:danger] = "正しいユーザーではありません"
        redirect_to current_user
      end
    end
end
