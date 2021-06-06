# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfferIdsForUserService do
  describe '#call' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:hash) do
      described_class
        .new(
          perfect_match_ids: perfect_match_ids,
          good_match_ids: good_match_ids,
          from_api_ids: from_api_ids,
          other_ids: other_ids
        )
        .call(user: user, params: {})
    end
    let(:perfect_match_ids) { instance_double(OfferIdsFromQueryService) }
    let(:good_match_ids) { instance_double(OfferIdsFromQueryService) }
    let(:from_api_ids) { instance_double(OfferIdsFromQueryService) }
    let(:other_ids) { instance_double(OfferIdsFromQueryService) }
    let(:user) { instance_double(User) }

    before do
      allow(perfect_match_ids).to receive(:call).with(user: user, params: {}).and_return([100])
      allow(good_match_ids).to receive(:call).with(user: user, params: {}).and_return([200])
      allow(from_api_ids).to receive(:call).with(user: user, params: {}).and_return([800])
      allow(other_ids).to receive(:call).with(user: user, params: {}).and_return([1000])
    end

    it 'returns hash with ids' do
      expect(hash).to eq(
        { perfect_match: [100], good_match: [200], from_api: [800], offer: [1000], all: [100, 200, 800, 1000] }
      )
    end
  end
end
