require 'test_helper'

class GroupsJoinTest < ActionDispatch::IntegrationTest
  
  def setup
    @group = groups(:superdry)
  end
  
  test "unsuccessful join" do
    get signup_path
    post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         employee_no: 123,
                                         password:              "password",
                                         password_confirmation: "password" } }
    user = assigns(:user)
    get edit_account_activation_path(user.activation_token, email: user.email)
    follow_redirect!
    assert_template 'static_pages/selection'
    get join_path
    post join_path, params: { joining: { name: "",
                                         password: "abc",
                                         password_confirmation: "cba" } }
    assert_template 'joinings/new'
    assert_not flash.empty?
  end
  
  test "join with ununique employee no" do
    get signup_path
    post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         employee_no: 12345,
                                         password:              "password",
                                         password_confirmation: "password" } }
    user = assigns(:user)
    get edit_account_activation_path(user.activation_token, email: user.email)
    follow_redirect!
    assert_template 'static_pages/selection'
    get join_path
    post join_path, params: { joining: { name: @group.name,
                                         password: "password",
                                         password_confirmation: "password" } }
    assert_not flash.empty?
    assert_redirected_to join_path
  end
  
  test "successful join" do
    get signup_path
    post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         employee_no: 123,
                                         password:              "password",
                                         password_confirmation: "password" } }
    user = assigns(:user)
    get edit_account_activation_path(user.activation_token, email: user.email)
    follow_redirect!
    assert_template 'static_pages/selection'
    get join_path
    post join_path, params: { joining: { name: @group.name,
                                         password: "password",
                                         password_confirmation: "password" } }
    assert_not flash.empty?
    assert_redirected_to user
  end
end
