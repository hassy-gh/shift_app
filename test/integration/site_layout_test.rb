require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end
  
  test "layout links" do
    # ログインしていない場合
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", login_path, count: 2
    # 管理者としてログインした場合
    log_in_as(@admin)
    assert_redirected_to @admin
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", user_path(@admin), count: 1
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", fixed_shifts_path, count: 1
    assert_select "a[href=?]", hope_shifts_path, count: 1
    assert_select "a[href=?]", edit_user_path(@admin), count: 1
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "div.simple-calendar", count: 1
    delete logout_path
    # 非管理者としてログインした場合
    log_in_as(@non_admin)
    assert_redirected_to @non_admin
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", user_path(@non_admin), count: 1
    assert_select "a[href=?]", hope_shifts_path, count: 1
    assert_select "a[href=?]", edit_user_path(@non_admin), count: 1
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "div.simple-calendar", count: 1
  end
end
