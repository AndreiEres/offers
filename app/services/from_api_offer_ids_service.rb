# frozen_string_literal: true

class FromApiOfferIdsService
  PERFECT_MATCH_QUERY = PerfectMatchOfferQuery.new(Offer.from_external_api)
  GOOD_MATCH_QUERY = GoodMatchOfferQuery.new(Offer.from_external_api)
  OTHER_QUERY = OtherOfferQuery.new(Offer.from_external_api)
  LIMIT = 5

  attr_reader :perfect_match_query, :good_match_query, :other_query

  def initialize(
    perfect_match_query: PerfectMatchOfferQuery.new(Offer.from_external_api),
    good_match_query: GoodMatchOfferQuery.new(Offer.from_external_api),
    other_query: OtherOfferQuery.new(Offer.from_external_api)
  )
    @perfect_match_query = perfect_match_query
    @good_match_query = good_match_query
    @other_query = other_query
  end

  def call(user:)
    return [] if user.blank?

    (perfect_match_ids(user) + good_match_ids(user) + other_ids(user))[...LIMIT]
  end

  private

  def perfect_match_ids(user)
    perfect_match_query
      .call(user: user)
      .limit(LIMIT)
      .pluck(:id)
  end

  def good_match_ids(user)
    good_match_query
      .call(user: user)
      .limit(LIMIT)
      .pluck(:id)
  end

  def other_ids(user)
    other_query
      .call(user: user)
      .limit(LIMIT)
      .pluck(:id)
  end
end
