# frozen_string_literal: true

# SessionController
class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[login create logout]
  before_action :skip_login, only: %i[login create]
  before_action :update_user_score, only: %i[logout]

  # Просто отдаём форму логина
  def login; end

  # Аутентификация
  def create
    # p "PARAMS", params
    user = User.find_by login: params[:login]

    if user&.authenticate(params[:password])
      sign_in user
      redirect_to clicker_index_path
    else
      flash[:danger] = 'Неправильные данные'
      redirect_to root_path
    end
  end

  # Выход
  def logout
    update_user_score
    sign_out
    redirect_to root_path
  end
end
