# frozen_string_literal: true

class Department < ApplicationRecord
  validates :name, presence: true

  has_many :offer_departments, dependent: :destroy
  has_many :offers, through: :offer_departments
end
