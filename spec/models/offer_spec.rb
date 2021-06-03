# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:company) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:offer_departments) }
    it { is_expected.to have_many(:departments) }
  end
end
