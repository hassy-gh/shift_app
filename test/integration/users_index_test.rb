require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @non_activated = users(:non_activated)
  end
  
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    assert_redirected_to @admin
    follow_redirect!
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', user_path(@non_activated), count: 0
    assert flash.empty?
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: "#{user.name}(#{user.employee_no})"
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: '削除'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
    assert_not flash.empty?
    get user_path(@non_activated)
    assert_redirected_to root_url
  end
end
