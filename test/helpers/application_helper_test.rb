require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  def setup
    @base_title = "ShiftApp"
  end
  
  test "full title helper" do
    assert_equal full_title, @base_title
    assert_equal full_title("Login"), "Login | #{@base_title}"
  end
end