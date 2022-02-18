# frozen_string_literal: true

require 'test_helper'

class ClickerControllerTest < ActionDispatch::IntegrationTest
  test "shouldn't get index" do
    get clicker_index_url
    assert_redirected_to root_path
  end

  test "shouldn't get click" do
    get clicker_click_url
    assert_redirected_to root_path
  end
end
