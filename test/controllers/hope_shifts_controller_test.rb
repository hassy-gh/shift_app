require 'test_helper'

class HopeShiftsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @hope_shift = hope_shifts(:one)
  end
  
  test "should get new" do
    log_in_as(@user)
    get new_hope_shift_path
    assert_response :success
  end
  
  test "should redirect index when not logged in" do
    get hope_shifts_path
    assert_redirected_to login_url
  end
  
  test "should redirect new when not logged in" do
    get new_hope_shift_path
    assert_redirected_to login_url
  end
  
  test "should redirect create when not logged in" do
    post hope_shifts_path, params: { hope_shift: { start_time: @hope_shift.start_time,
                                                   hope_start_time: @hope_shift.hope_start_time,
                                                   hope_end_time: @hope_shift.hope_end_time } }
    assert_redirected_to login_url
  end
  
  test "should redirect edit when not logged in" do
    get edit_hope_shift_path(@hope_shift)
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch hope_shift_path(@hope_shift), params: { hope_shift: { start_time: "2021-11-01",
                                                   content: "F" } }
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in wrong user" do
    log_in_as(@other_user)
    get edit_hope_shift_path(@hope_shift)
    assert_not flash.empty?
    assert_redirected_to @other_user
  end
  
  test "should redirect update when logged in wrong user" do
    log_in_as(@other_user)
    patch hope_shift_path(@hope_shift), params: { hope_shift: { start_time: "2021-11-01",
                                                   content: "F" } }
    assert_not flash.empty?
    assert_redirected_to @other_user
  end
end
