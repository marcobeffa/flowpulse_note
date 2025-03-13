require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get utenti" do
    get pages_utenti_url
    assert_response :success
  end
end
