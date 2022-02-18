# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    visit root_url(locale: 'ru')
    # Creating one test user
    @login = Faker::Lorem.word
    @password = Faker::Lorem.word
  end

  test 'leaderboards' do
    visit users_url
    assert_selector 'h1', text: 'Списки лидеров'
  end

  test 'creating a User' do
    visit new_user_url
    fill_in 'user_login', with: @login
    fill_in 'user_password', with: @password
    fill_in 'user_password_confirmation', with: @password
    click_on 'commit'
    assert_selector 'div.my-score'
  end

  def sign_in
    visit new_user_url
    fill_in 'user_login', with: @login
    fill_in 'user_password', with: @password
    fill_in 'user_password_confirmation', with: @password
    click_on 'commit'
  end
end
