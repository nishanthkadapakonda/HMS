require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get accesserror" do
    get errors_accesserror_url
    assert_response :success
  end

end
