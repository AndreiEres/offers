# frozen_string_literal: true

class OffersController < ApplicationController
  def index
    ids = OfferIdsForUserService.new.call(user: user, params: params)
    pagy, records = pagy(Offer.by_ids(ids[:all]))

    render json: {
      data: records.map { |r| OfferSerializer.new(r, ids).as_json },
      **pagy_metadata(pagy)
    }
  end

  private

  def user
    User.find_by(id: params[:user_id])
  end
end
