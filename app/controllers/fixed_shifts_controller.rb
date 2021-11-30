class FixedShiftsController < ApplicationController
  before_action :logged_in_user
  before_action :no_join_user
  before_action :get_group, only: [:index, :new, :create, :edit, :update, :day_index, :toggle_status, :draft]
  before_action :get_fixed_shift, only: [:edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy, :line_notify, :toggle_status, :draft]

  def index
    @fixed_shifts = @group.fixed_shifts.where(status: 1)
  end
  
  def draft
    @fixed_shifts = @group.fixed_shifts.all
  end
  
  def toggle_status
    if params[:start_date] && params[:end_date]
      if !params[:start_date].blank? && !params[:end_date].blank?
        start_date = params[:start_date]
        end_date = params[:end_date]
        @fixed_shifts = @group.fixed_shifts.where(status: 0).where(start_time: start_date..end_date)
        @fixed_shifts.map(&:published!)
        flash[:success] = "公開しました"
        redirect_to fixed_shifts_path
      elsif params[:start_date].blank? || params[:end_date].blank?
        flash[:danger] = "日付を選択してください"
        redirect_to draft_fixed_shifts_path
      end
    else
      @fixed_shifts = @group.fixed_shifts.where(status: 0)
      @fixed_shifts.map(&:published!)
      flash[:success] = "公開しました"
      redirect_to fixed_shifts_path
    end
  end
  
  def line_notify
    line = Line.new
    line.send("シフトが確定しました！ https://shift-app-2021.herokuapp.com/fixed_shifts")
    flash[:success] = "LINEに通知しました"
    redirect_to fixed_shifts_path
  end
  
  def new
    @day = params[:format]
    @user = @group.users.find(params[:id]).id
    @fixed_shift = FixedShift.new
  end
  
  def create
    @fixed_shift = FixedShift.new(fixed_shift_params)
    if @fixed_shift.save
      flash[:success] = "登録しました"
      redirect_to day_index_fixed_shifts_path(params[:fixed_shift][:start_time])
    else
      @day = params[:fixed_shift][:start_time]
      @user = params[:fixed_shift][:user_id]
      render "new"
    end
  end
  
  def edit
    @day = @fixed_shift.start_time
    @user = @fixed_shift.user_id
  end
  
  def update
    if @fixed_shift.update(fixed_shift_params)
      flash[:success] = "変更しました"
      redirect_to day_index_fixed_shifts_path(params[:fixed_shift][:start_time])
    else
      @day = @fixed_shift.start_time
      @user = @fixed_shift.user_id
      render 'edit'
    end
  end
  
  def destroy
    @fixed_shift.destroy
    flash[:success] = "削除しました"
    redirect_to day_index_fixed_shifts_path(@fixed_shift.start_time)
  end
  
  def day_index
    @day = params[:format]
    @users = @group.users
    @fixed_shifts = @group.fixed_shifts.where(start_time: @day)
    @hope_shifts = @group.hope_shifts.where(start_time: @day)
  end
  
  private
  
    def fixed_shift_params
      params.require(:fixed_shift).permit(:user_id, :start_time, :fixed_start_time, :fixed_end_time, :absence, :status)
    end
    
    # カレンダーの範囲
    class SimpleCalendar::CurrentMonthCalendar < SimpleCalendar::MonthCalendar
      private
      
        def date_range
          beginning = start_date.beginning_of_month
          ending    = start_date.end_of_month
          (beginning..ending).to_a
        end
    end
    
    require 'net/http'
    require 'uri'
    
    # LINEで通知する
    class Line
      TOKEN = "9XvCN3N3DLTyLpGV3mpmknTaVqHtS24mof6cxYW1jzE"
      URI = URI.parse("https://notify-api.line.me/api/notify")
    
      def make_request(msg)
        request = Net::HTTP::Post.new(URI)
        request["Authorization"] = "Bearer #{TOKEN}"
        request.set_form_data(message: msg)
        request
      end
    
      def send(msg)
        request = make_request(msg)
        response = Net::HTTP.start(URI.hostname, URI.port, use_ssl: URI.scheme == "https") do |https|
          https.request(request)
        end
      end
    end
end
