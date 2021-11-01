require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "ShiftApp"
    @user = users(:michael)
    @non_joined = users(:lana)
  end
  
  test "should get root" do
    get root_url
    assert_response :success
  end
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", @base_title
  end
  
  test "should get selection" do
    log_in_as(@non_joined)
    get selection_path
    assert_response :success
  end
  
  test "should redirect selection when not logged in" do
    get selection_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect selection when joined group" do
    log_in_as(@user)
    get selection_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
