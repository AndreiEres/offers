# frozen_string_literal: true

class OfferIdsForUserService
  PERFECT_MATCH_QUERY = PerfectMatchOfferQuery.new(Offer.not_from_external_api)
  GOOD_MATCH_QUERY = GoodMatchOfferQuery.new(Offer.not_from_external_api)
  FROM_API_QUERY = FromApiOfferQuery.new(Offer.from_external_api)
  OTHER_QUERY = OtherOfferQuery.new(Offer.not_from_external_api)

  attr_reader :perfect_match_ids, :good_match_ids, :from_api_ids, :other_ids

  def initialize(
    perfect_match_ids: OfferIdsFromQueryService.new(PERFECT_MATCH_QUERY),
    good_match_ids: OfferIdsFromQueryService.new(GOOD_MATCH_QUERY),
    from_api_ids: OfferIdsFromQueryService.new(FROM_API_QUERY),
    other_ids: OfferIdsFromQueryService.new(OTHER_QUERY)
  )
    @perfect_match_ids = perfect_match_ids
    @good_match_ids = good_match_ids
    @from_api_ids = from_api_ids
    @other_ids = other_ids
  end

  def call(user:, params: {}) # rubocop:todo Metrics/MethodLength
    perfect_match = perfect_match_ids.call(user: user, params: params)
    good_match = good_match_ids.call(user: user, params: params)
    from_api = from_api_ids.call(user: user, params: params)
    other = other_ids.call(user: user, params: params)

    {
      perfect_match: perfect_match,
      good_match: good_match,
      from_api: from_api,
      offer: other,
      all: perfect_match + good_match + from_api + other
    }
  end
end
