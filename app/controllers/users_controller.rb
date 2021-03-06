class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :no_join_user, only: [:index, :show]
  before_action :get_user, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :get_group, only: :index
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index, :destroy]
  
  def index
    @users = @group.users.where(activated: true).order(:employee_no).paginate(page: params[:page])
  end
  
  def show
    @fixed_shifts = @user.fixed_shifts.all
    redirect_to root_url and return unless @user.activated?
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "ご登録いただいたメールアドレスに本登録メールを送信しました"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "変更を保存しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "削除しました"
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user)
      .permit(:name, :email, :employee_no, :password, :password_confirmation)
    end
    
    # beforeアクション
    
    # 正しいユーザーかどうか確認
    def correct_user
      unless current_user?(@user)
        flash[:danger] = "正しいユーザーではありません"
        redirect_to(current_user)
      end
    end
end
