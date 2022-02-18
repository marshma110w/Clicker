# frozen_string_literal: true

# ClickerHelper
module ClickerHelper
  def level_up?(score, level)
    (score >= (10 * level)**2)
  end
end
