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

  describe '.match_company' do
    subject { described_class.match_company(company) }

    let(:offer) { create(:offer, company: 'Apple') }

    context 'when offer with the company exists' do
      let(:company) { 'Apple' }

      it { is_expected.to eq([offer]) }
    end

    context 'when offer with the company does not exist' do
      let(:company) { 'Google' }

      it { is_expected.to eq([]) }
    end
  end

  describe '.match_departments' do
    subject { described_class.match_department_names(department_names) }

    let(:offer) { create(:offer) }

    before do
      offer.departments << create(:department, name: 'IT')
    end

    context 'when offer with at least one department exists' do
      let(:department_names) { %w[IT Accounting] }

      it { is_expected.to eq([offer]) }
    end

    context 'when offer with the departments does not exist' do
      let(:department_names) { %w[Management Sales] }

      it { is_expected.to eq([]) }
    end
  end
end
