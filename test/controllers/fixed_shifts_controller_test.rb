require 'test_helper'

class FixedShiftsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get fixed_shifts_new_url
    assert_response :success
  end

end
