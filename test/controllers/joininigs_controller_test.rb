require 'test_helper'

class JoininigsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @non_joined = users(:lana)
    @group = groups(:superdry)
  end
  
  test "should get new" do
    log_in_as(@non_joined)
    get join_path
    assert_response :success
  end
  
  test "should redirect new when not logged in" do
    get join_path
    assert_redirected_to login_url
  end
  
  test "should redirect create when not logged in" do
    post join_path, params: { joining: { name: @group.name,
                                         password: "password",
                                         password_confirmation: "password" } }
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in/not joined group" do
    patch leave_path
    assert_redirected_to login_url
    log_in_as(@non_joined)
    patch leave_path
    assert_redirected_to selection_path
  end
  
  test "should redirect update when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference '@group.users.count' do
      patch leave_path(format: @user)
    end
    assert_redirected_to root_url
  end
  
  test "should redirect new when joined group" do
    log_in_as(@user)
    get join_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect create when joined group" do
    log_in_as(@user)
    post join_path, params: { joining: { name: "example",
                                         password: "password",
                                         password_confirmation: "password" } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
