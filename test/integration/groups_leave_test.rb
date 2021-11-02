require 'test_helper'

class GroupsLeaveTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @group = groups(:superdry)
  end
  
  test "leave when admin" do
    log_in_as(@admin)
    get users_path
    assert_difference '@group.users.count', -1 do
      patch leave_path(format: @non_admin.id)
    end
    assert_not flash.empty?
    assert_redirected_to users_path
  end
end
