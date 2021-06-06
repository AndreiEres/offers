# frozen_string_literal: true

class OfferIdsForUserService
  attr_reader :perfect_match_ids, :good_match_ids, :other_ids

  def initialize(
    perfect_match_ids: OfferIdsFromQueryService.new(PerfectMatchOfferQuery.new),
    good_match_ids: OfferIdsFromQueryService.new(GoodMatchOfferQuery.new),
    other_ids: OfferIdsFromQueryService.new(OtherOfferQuery.new)
  )
    @perfect_match_ids = perfect_match_ids
    @good_match_ids = good_match_ids
    @other_ids = other_ids
  end

  def call(user:)
    perfect_match = perfect_match_ids.call(user: user)
    good_match = good_match_ids.call(user: user)
    other = other_ids.call(user: user)

    {
      perfect_match: perfect_match,
      good_match: good_match,
      other: other,
      all: perfect_match + good_match + other
    }
  end
end
