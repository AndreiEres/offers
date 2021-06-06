# frozen_string_literal: true

class OfferSerializer
  attr_reader :instance, :params

  def initialize(instance, params = {})
    @instance = instance
    @params = params
  end

  def as_json
    instance
      .as_json(only: %i[id price company])
      .merge('label' => label)
  end

  private

  def label
    OfferLabel.new(id: instance.id, ids: params).to_s
  end
end
