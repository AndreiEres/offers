# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FromApiOfferIdsService do
  describe '#call' do # rubocop:todo RSpec/MultipleMemoizedHelpers
    let(:query) do
      described_class
        .new(
          perfect_match_query: perfect_match_query,
          good_match_query: good_match_query,
          other_query: other_query
        )
        .call(user: user)
    end
    let(:perfect_match_query) { instance_double(PerfectMatchOfferQuery) }
    let(:good_match_query) { instance_double(GoodMatchOfferQuery) }
    let(:other_query) { instance_double(OtherOfferQuery) }
    let(:perfect_match_rel) { class_double(Offer) }
    let(:good_match_rel) { class_double(Offer) }
    let(:other_rel) { class_double(Offer) }
    let(:user) { instance_double(User) }

    before do
      allow(perfect_match_query).to receive(:call).with(user: user).and_return(perfect_match_rel)
      allow(good_match_query).to receive(:call).with(user: user).and_return(good_match_rel)
      allow(other_query).to receive(:call).with(user: user).and_return(other_rel)

      allow(perfect_match_rel).to receive(:limit).with(5).and_return(perfect_match_rel)
      allow(good_match_rel).to receive(:limit).with(5).and_return(good_match_rel)
      allow(other_rel).to receive(:limit).with(5).and_return(other_rel)

      allow(perfect_match_rel).to receive(:pluck).with(:id).and_return([1, 2])
      allow(good_match_rel).to receive(:pluck).with(:id).and_return([9, 10])
      allow(other_rel).to receive(:pluck).with(:id).and_return([15, 16])
    end

    it 'returns offers collected by ids' do
      expect(query).to eq([1, 2, 9, 10, 15])
    end

    context 'when user does not exist' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:user) { nil }

      it 'returns empty relation' do
        expect(query).to eq([])
      end
    end
  end
end
