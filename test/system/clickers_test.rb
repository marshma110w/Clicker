# frozen_string_literal: true

require 'application_system_test_case'

class ClickersTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit clickers_url
  #
  #   assert_selector "h1", text: "Clicker"
  # end

  setup do
    visit root_url(locale: 'ru')
    # Creating one test user
    @login = Faker::Lorem.word
    @password = Faker::Lorem.word
  end

  test 'visiting login' do
    visit root_url
    assert_selector 'h1', text: 'Авторизация'
  end

  test 'visiting clicker index' do
    sign_in
    assert_selector 'div.my-score'
  end

  test 'checking score' do
    sign_in
    assert_selector 'div.my-score', text: "Очки: 0/100\nУровень: 1  "
    5.times do
      click_on 'click_button'
    end
    assert_selector 'div.my-score', text: "Очки: 5/100\nУровень: 1  "
  end

  def sign_in
    visit new_user_url
    fill_in 'user_login', with: @login
    fill_in 'user_password', with: @password
    fill_in 'user_password_confirmation', with: @password
    click_on 'commit'
  end
end
