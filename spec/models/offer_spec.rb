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

  describe '.not_match_company' do
    subject { described_class.not_match_company(company) }

    let(:offer) { create(:offer, company: 'Apple') }

    context 'when offer with the company exists' do
      let(:company) { 'Apple' }

      it { is_expected.to eq([]) }
    end

    context 'when offer with the company does not exist' do
      let(:company) { 'Google' }

      it { is_expected.to eq([offer]) }
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

  describe '.not_match_departments' do
    subject { described_class.not_match_department_names(department_names) }

    let(:offer) { create(:offer) }

    before do
      offer.departments << create(:department, name: 'IT')
    end

    context 'when offer with at least one department exists' do
      let(:department_names) { %w[IT Accounting] }

      it { is_expected.to eq([]) }
    end

    context 'when offer with the departments does not exist' do
      let(:department_names) { %w[Management Sales] }

      it { is_expected.to eq([offer]) }
    end
  end

  describe '.by_ids' do
    subject { described_class.by_ids(ids) }

    let(:offers) { create_list(:offer, 5) }
    let(:ids) { result.map(&:id) }
    let(:result) { [offers[4], offers[1], offers[3]] }

    it { is_expected.to eq(result) }
  end

  describe '.company_like' do
    subject { described_class.company_like(query) }

    let(:query) { 'AP' }
    let(:offer) { create(:offer, company: 'Apple') }

    before do
      create(:offer, company: 'Google')
    end

    it { is_expected.to eq([offer]) }
  end

  describe '.by_department_ids' do
    subject { described_class.by_department_ids(ids) }

    let(:ids) { [42] }
    let(:offer) { create(:offer) }

    before do
      offer.departments << create(:department, id: 42)
      create(:offer, company: 'Google')
    end

    it { is_expected.to eq([offer]) }
  end

  describe '.from_external_api' do
    subject { described_class.from_external_api }

    let(:offer) { create(:offer, from_external_api: true) }

    before do
      create(:offer)
    end

    it { is_expected.to eq([offer]) }
  end

  describe '.not_from_external_api' do
    subject { described_class.not_from_external_api }

    let(:offer) { create(:offer) }

    before do
      create(:offer, from_external_api: true)
    end

    it { is_expected.to eq([offer]) }
  end
end
