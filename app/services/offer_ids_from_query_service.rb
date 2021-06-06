# frozen_string_literal: true

class OfferIdsFromQueryService
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def call(user:)
    query.call(user: user).pluck(:id)
  end
end
