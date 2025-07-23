require "test_helper"

class DomainControllerTest < ActionDispatch::IntegrationTest
  test "should get markpostura" do
    get domain_markpostura_url
    assert_response :success
  end
end
