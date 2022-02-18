# frozen_string_literal: true

require 'test_helper'

class UserUsabilityTest < ActionDispatch::IntegrationTest
  setup do
    # Creating one test user
    @login = Faker::Lorem.word
    @password = Faker::Lorem.word
    post users_path(user: { "login": @login, "password": @password, "password_confirmation": @password })
    @id = User.find_by(login: @login).id
  end

  test 'should sign in' do
    post session_create_path('login': @login, 'password': @password)
    assert_redirected_to clicker_index_path
  end

  test 'shoud edit' do
    # Логинимся
    post session_create_path('login': @login, 'password': @password)
    assert_redirected_to clicker_index_path
    # Придумали новы пароль
    @new_pas = Faker::Lorem.word
    # Поменяли пароль
    put user_path('id': @id, user: { "login": @login, "password": @new_pas, "password_confirmation": @new_pas })
    # Разлогинились
    get session_logout_path
    assert_redirected_to root_path
    # Безуспешный вход со старым паролем
    post session_create_path('login': @login, 'password': @password)
    assert_redirected_to root_path
    # Успешный вход с новым паролем
    post session_create_path('login': @login, 'password': @new_pas)
    assert_redirected_to clicker_index_path
  end

  test 'should get update' do
    post session_create_path('login': @login, 'password': @password)
    assert_redirected_to clicker_index_path
    get edit_user_path(id: @id)
    assert_response :success
  end

  test 'should destroy user' do
    post session_create_path('login': @login, 'password': @password)
    assert_redirected_to clicker_index_path
    delete user_path(id: @id)
    assert_redirected_to users_path
    post session_create_path('login': @login, 'password': @password)
    assert_redirected_to root_path
  end
end
