# frozen_string_literal: true

require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get session_login_url
    assert_response :success
  end

  test "shouldn't logout" do
    get session_logout_url
    assert_redirected_to root_path
  end
end
