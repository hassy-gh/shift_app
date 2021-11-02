require 'test_helper'

class GroupsNewTest < ActionDispatch::IntegrationTest
  
  def setup
    @group = groups(:superdry)
  end
  
  test "unsuccessful new" do
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
    get new_group_path
    post groups_path, params: { group: { name: "",
                                         password: "abc",
                                         password_confirmation: "cba" } }
    assert_template 'groups/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "new with ununique name" do
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
    get new_group_path
    post groups_path, params: { group: { name: @group.name,
                                         password: "foobar",
                                         password_confirmation: "foobar" } }
    assert_template 'groups/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "successful new" do
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
    get new_group_path
    post groups_path, params: { group: { name: "Example.Co",
                                         password: "password",
                                         password_confirmation: "password" } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
