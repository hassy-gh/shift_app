require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @non_joined = users(:lana)
    @group = groups(:superdry)
  end
  
  test "should get new" do
    log_in_as(@non_joined)
    get new_group_path
    assert_response :success
  end
  
  test "should redirect new when not logged in" do
    get new_group_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect create when not logged in" do
    post groups_path, params: { group: { name: @group.name,
                                         password: "password",
                                         password_confirmation: "password" } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect new when joined group" do
    log_in_as(@user)
    get new_group_path
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect create when joined group" do
    log_in_as(@user)
    post groups_path, params: { group: { name: "example",
                                         password: "password",
                                         password_confirmation: "password" } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
