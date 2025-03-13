require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get private" do
    get dashboard_private_url
    assert_response :success
  end

  test "should get group" do
    get dashboard_group_url
    assert_response :success
  end

  test "should get public" do
    get dashboard_public_url
    assert_response :success
  end

  test "should get published" do
    get dashboard_published_url
    assert_response :success
  end

  test "should get future" do
    get dashboard_future_url
    assert_response :success
  end
end
