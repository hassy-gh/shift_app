require 'test_helper'

class FixedShiftsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @fixed_shift = fixed_shifts(:one)
  end
  
  test "should get new" do
    log_in_as(@user)
    get new_fixed_shift_path(id: @user)
    assert_response :success
  end
  
  test "should redirect index when not logged in" do
    get fixed_shifts_path
    assert_redirected_to login_url
  end
  
  test "should redirect new when not logged in" do
    get new_fixed_shift_path
    assert_redirected_to login_url
  end
  
  test "should redirect create when not logged in" do
    post fixed_shifts_path, params: { fixed_shift: { start_time: @fixed_shift.start_time,
                                                   fixed_start_time: @fixed_shift.fixed_start_time,
                                                   fixed_end_time: @fixed_shift.fixed_end_time } }
    assert_redirected_to login_url
  end
  
  test "should redirect edit when not logged in" do
    get edit_fixed_shift_path(@fixed_shift)
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch fixed_shift_path(@fixed_shift), params: { fixed_shift: { start_time: "2021-11-01",
                                                   absence: true } }
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    delete fixed_shift_path(@fixed_shift)
    assert_redirected_to login_url
  end
  
  test "should redirect index when not admin" do
    log_in_as(@other_user)
    get fixed_shifts_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect new when not admin" do
    log_in_as(@other_user)
    get new_fixed_shift_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect create when not admin" do
    log_in_as(@other_user)
    post fixed_shifts_path, params: { fixed_shift: { start_time: @fixed_shift.start_time,
                                                   fixed_start_time: @fixed_shift.fixed_start_time,
                                                   fixed_end_time: @fixed_shift.fixed_end_time } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect edit when not admin" do
    log_in_as(@other_user)
    get edit_fixed_shift_path(@fixed_shift)
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when not admin" do
    log_in_as(@other_user)
    patch fixed_shift_path(@fixed_shift), params: { fixed_shift: { start_time: "2021-11-01",
                                                   absence: true } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect destroy when not admin" do
    log_in_as(@other_user)
    delete fixed_shift_path(@fixed_shift)
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
