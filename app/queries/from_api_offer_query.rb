# frozen_string_literal: true

class FromApiOfferQuery
  attr_reader :repo

  def initialize(repo = Offer)
    @repo = repo
  end

  def call(user:)
    return repo.none if user.blank?

    repo.by_ids(ids(user))
  end

  private

  def ids(user)
    FromApiOfferIdsService.new.call(user: user)
  end
end
