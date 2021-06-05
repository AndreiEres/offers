# frozen_string_literal: true

class GoodMatchOfferQuery
  attr_reader :repo

  def initialize(repo = Offer)
    @repo = repo
  end

  def call(user:)
    return repo.none if user.blank?

    repo
      .match_company(user.company)
      .not_match_department_names(user.department_names)
  end
end
