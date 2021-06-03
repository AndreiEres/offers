# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:offer_departments) }
    it { is_expected.to have_many(:offers) }

    it { is_expected.to have_many(:user_departments) }
    it { is_expected.to have_many(:users) }
  end
end
