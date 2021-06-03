# frozen_string_literal: true

class OfferDepartment < ApplicationRecord
  belongs_to :offer
  belongs_to :department
end
