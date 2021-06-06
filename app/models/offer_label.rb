# frozen_string_literal: true

class OfferLabel
  attr_reader :id, :ids

  delegate :to_s, to: :label

  def initialize(id:, ids:)
    @id = id
    @ids = ids
  end

  private

  def label
    ids
      .select { |_, arr| arr.include?(id) }
      .keys
      .first
  end
end
