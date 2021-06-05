# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoodMatchOfferQuery, type: :model do
  describe '#call' do
    let(:query) { described_class.new(repo).call(user: user) }
    let(:repo) { class_double(Offer, none: []) }
    let(:user) { instance_double(User, company: 'Apple', department_names: %w[IT]) }
    let(:good_match) { [instance_double(Offer)] }

    before do
      allow(repo).to receive(:match_company).and_return(repo)
      allow(repo).to receive(:not_match_department_names).and_return(good_match)
    end

    it 'returns checks offers with matched company name' do
      query

      expect(repo).to have_received(:match_company).with('Apple')
    end

    it 'returns checks offers with not matched department names' do
      query

      expect(repo).to have_received(:not_match_department_names).with(%w[IT])
    end

    it 'returns offers with good match' do
      expect(query).to eq(good_match)
    end

    context 'when user does not exist' do
      let(:user) { nil }

      it 'returns empty relation' do
        expect(query).to eq([])
      end
    end
  end
end
