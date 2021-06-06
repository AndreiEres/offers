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
  scope :by_ids, lambda { |ids|
    clause_by_id = ids.each_with_index.map { |id, i| sanitize_sql_array(['WHEN ? THEN ? ', id, i]) }.join
    else_clause = sanitize_sql_array(['ELSE ? END', ids.length])
    order_clause = "CASE id #{clause_by_id}#{else_clause}"

    where(id: ids).order(Arel.sql(order_clause))
  }
  scope :company_like, ->(query) { where('LOWER(company) LIKE ?', "%#{query&.downcase}%") }
  scope :by_department_ids, ->(ids) { joins(:departments).where(departments: { id: ids }) }
  scope :from_external_api, -> { where(from_external_api: true) }
  scope :not_from_external_api, -> { where.not(from_external_api: true) }
end
