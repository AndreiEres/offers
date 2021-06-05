# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OtherOfferQuery, type: :model do
  describe '#call' do
    let(:query) { described_class.new(repo).call(user: user) }
    let(:repo) { class_double(Offer, none: []) }
    let(:user) { instance_double(User, company: 'Apple') }
    let(:other) { [instance_double(Offer)] }

    before do
      allow(repo).to receive(:not_match_company).and_return(other)
    end

    it 'returns checks offers with not matched company name' do
      query

      expect(repo).to have_received(:not_match_company).with('Apple')
    end

    it 'returns other offers' do
      expect(query).to eq(other)
    end

    context 'when user does not exist' do
      let(:user) { nil }

      it 'returns empty relation' do
        expect(query).to eq([])
      end
    end
  end
end
