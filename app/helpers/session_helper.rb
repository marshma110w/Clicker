# frozen_string_literal: true

# SessionHelper
module SessionHelper
  def sign_in(user)
    # p 'МЕТОД SIGN_IN'
    # p user
    cookies.signed[:user_id] = { value: user.id, expires: 1.days, http_only: true }
    cookies.signed[:user_score] = { value: user.total_score, http_only: true }
    cookies.signed[:user_level] = { value: user.level, http_only: true }
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    # p "Обнуляем куки"
    cookies.signed[:user_id] = nil
    cookies.signed[:user_score] = nil
    cookies.signed[:user_level] = nil
    # p "Обнулили куки"

    self.current_user = nil
    # p "Обнулили current_user"
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    # p "МЕТОД ГЕТТЕР"
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
    # p @current_user
  end
end
