require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user =users(:michael)
  end
  
  test "login with valid employee_no/invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { employee_no: "12345", password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { employee_no: @user.employee_no,
                                    password: "password" } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # ２番目のウィンドウでログアウトをクリックするユーザーをシュミレートする
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 2
    assert_select "a[href=?]", logout_path, count: 0
  end
  
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end
  
  test "login without remembering" do
    # cookiesを保存してログイン
    log_in_as(@user, remember_me: '1')
    delete logout_path
    # cookiesを削除してログイン
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end
end
