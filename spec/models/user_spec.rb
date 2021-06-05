# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:company) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:user_departments) }
    it { is_expected.to have_many(:departments) }
  end

  describe '#department_names' do
    subject { user.department_names }

    let(:user) { create(:user) }

    before { user.departments << create(:department, name: 'IT') }

    it { is_expected.to eq(%w[IT]) }
  end
end
