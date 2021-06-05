# frozen_string_literal: true

class OfferSerializer
  attr_reader :instance

  def initialize(instance)
    @instance = instance
  end

  def as_json
    instance.as_json(only: %i[id price company])
  end
end
