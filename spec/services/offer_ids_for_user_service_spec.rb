# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfferIdsForUserService do
  describe '#call' do
    subject do
      described_class
        .new(
          perfect_match_ids: perfect_match_ids,
          good_match_ids: good_match_ids,
          other_ids: other_ids
        )
        .call(user: user, params: {})
    end

    let(:perfect_match_ids) { instance_double(OfferIdsFromQueryService) }
    let(:good_match_ids) { instance_double(OfferIdsFromQueryService) }
    let(:other_ids) { instance_double(OfferIdsFromQueryService) }
    let(:user) { instance_double(User) }

    before do
      allow(perfect_match_ids).to receive(:call).with(user: user, params: {}).and_return([100])
      allow(good_match_ids).to receive(:call).with(user: user, params: {}).and_return([200])
      allow(other_ids).to receive(:call).with(user: user, params: {}).and_return([1000])
    end

    it { is_expected.to eq({ perfect_match: [100], good_match: [200], other: [1000], all: [100, 200, 1000] }) }
  end
end
