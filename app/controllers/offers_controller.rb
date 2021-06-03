# frozen_string_literal: true

class OffersController < ApplicationController
  def index
    render json: Offer.all
  end
end
