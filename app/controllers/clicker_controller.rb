# frozen_string_literal: true

# ClickerController
class ClickerController < ApplicationController
  def index; end

  def click
    level = cookies.signed[:user_level]

    score = cookies.signed[:user_score] + level
    cookies.signed[:user_score] = score

    if level_up?(score, level)
      cookies.signed[:user_level] = level + 1
      update_user_score
      render json: { action: 'level_up', level: level + 1, score: score }
    else
      render json: { action: 'click', score: score }
    end
  end
end
