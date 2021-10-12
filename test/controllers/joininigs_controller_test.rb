require 'test_helper'

class JoininigsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get joininigs_new_url
    assert_response :success
  end

end
