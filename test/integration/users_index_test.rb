require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @other_group = users(:lana)
    @non_activated = users(:non_activated)
    @group = groups(:superdry)
  end
  
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    assert_redirected_to @admin
    follow_redirect!
    get users_path
    assert_template 'users/index'
    assert_no_match @non_activated.name, response.body
    assert_no_match @other_group.name, response.body
    assert flash.empty?
    assert_select 'div.pagination'
    first_page_of_users = @group.users.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_match "#{user.name}(#{user.employee_no})", response.body
      unless user == @admin
        assert_select 'a[href=?]', leave_path(format: user.id), text: '削除'
      end
    end
    assert_difference '@group.users.count', -1 do
      patch leave_path(format: @non_admin.id)
    end
    assert_not flash.empty?
    get user_path(@non_activated)
    assert_redirected_to @admin
  end
end
