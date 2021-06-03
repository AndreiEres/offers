# frozen_string_literal: true

class Offer < ApplicationRecord
  validates :price, :company, presence: true

  has_many :offer_departments, dependent: :destroy
  has_many :departments, through: :offer_departments
end
