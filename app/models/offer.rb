# frozen_string_literal: true

class Offer < ApplicationRecord
  validates :price, :company, presence: true
end
