# frozen_string_literal: true

class OfferIdsFromQueryService
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def call(user:, params: {}) # rubocop:todo Metrics/AbcSize
    relation = query.call(user: user)
    relation = relation.company_like(params[:query]) if params[:query]
    relation = relation.by_department_ids(params[:department_id]) if params[:department_id]
    relation = relation.order(price: params[:sort]&.downcase&.to_sym) if %w[asc desc].include?(params[:sort]&.downcase)

    relation.pluck(:id)
  end
end
