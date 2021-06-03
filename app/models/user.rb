# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, :company, presence: true
end
