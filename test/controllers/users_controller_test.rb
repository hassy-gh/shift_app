require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @no_join = users(:lana)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  test "should redirect index when not logged in/not joined group" do
    get users_path
    assert_redirected_to login_url
    log_in_as(@no_join)
    get users_path
    assert_redirected_to selection_path
  end
  
  test "should redirect show when not logged in/not joined group" do
    get user_path(@user)
    assert_redirected_to login_url
    log_in_as(@no_join)
    get user_path(@user)
    assert_redirected_to selection_path
  end
  
  test "should redirect edit when not logged in/not joined group" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
    log_in_as(@no_join)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to selection_path
  end
  
  test "should redirect update when not logged in/not joined group" do
    patch user_path(@user), params: { user: { name: @user.name,
                                      email: @user.email,
                                      employee_no: @user.employee_no } }
    assert_not flash.empty?
    assert_redirected_to login_url
    log_in_as(@no_join)
    patch user_path(@user), params: { user: { name: @user.name,
                                      email: @user.email,
                                      employee_no: @user.employee_no } }
    assert_not flash.empty?
    assert_redirected_to selection_path
  end
  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                user: { password: "password",
                                        password_confirmation: "password",
                                        admin: true } }
    assert_not @other_user.reload.admin?
  end
  
  test "should redirect show when logged in wrong user" do
    log_in_as(@other_user)
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to @other_user
  end
  
  test "should redirect edit when logged in wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to @other_user
  end

  test "should redirect update when logged in wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                      email: @user.email,
                                      employee_no: @user.employee_no } }
    assert_not flash.empty?
    assert_redirected_to @other_user
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
  
  test "should redirect index when not admin" do
    log_in_as(@other_user)
    get users_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
