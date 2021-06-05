# frozen_string_literal: true

class OtherOfferQuery
  attr_reader :repo

  def initialize(repo = Offer)
    @repo = repo
  end

  def call(user:)
    return repo.none if user.blank?

    repo
      .not_match_company(user.company)
  end
end
