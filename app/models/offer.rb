# frozen_string_literal: true

class Offer < ApplicationRecord
  validates :price, :company, presence: true

  has_many :offer_departments, dependent: :destroy
  has_many :departments, through: :offer_departments

  scope :match_company, ->(company) { where(company: company) }
  scope :not_match_company, ->(company) { where.not(company: company) }
  scope :match_department_names, lambda { |department_names|
    joins(:departments).where(departments: { name: department_names })
  }
  scope :not_match_department_names, lambda { |department_names|
    joins(:departments).where.not(departments: { name: department_names })
  }
  scope :by_ids, ->(ids) { where(id: ids) }
end
