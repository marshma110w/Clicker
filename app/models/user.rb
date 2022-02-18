# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  paginates_per 10
end
