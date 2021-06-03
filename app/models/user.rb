# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, :company, presence: true

  has_many :user_departments, dependent: :destroy
  has_many :departments, through: :user_departments
end
