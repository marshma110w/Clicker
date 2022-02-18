# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include SessionHelper
  include ClickerHelper

  before_action :require_login
  around_action :switch_locale

  def update_user_score
    # p 'update score method'
    return unless signed_in?

    User.find(cookies.signed[:user_id]).update_columns(level: cookies.signed[:user_level],
                                                       total_score: cookies.signed[:user_score])
  end

  def require_login
    # p 'require login method'
    return if signed_in?

    # p "NOT SIGNED, REDIRECTING TO LOGIN"
    redirect_to root_path
  end

  def skip_login
    # p 'skip login method'
    return unless signed_in?

    redirect_to clicker_index_path
    # p "SIGNED IN, REDIRECTING TO INdeX"
  end

  private

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
