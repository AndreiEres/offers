# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FromApiOfferQuery, type: :model do
  describe '#call' do
    let(:query) { described_class.new(repo).call(user: user) }
    let(:repo) { class_double(Offer, none: []) }
    let(:user) { instance_double(User) }
    let(:from_api) { [instance_double(Offer)] }
    let(:ids_service) { instance_double(FromApiOfferIdsService) }

    before do
      allow(FromApiOfferIdsService).to receive(:new).and_return(ids_service)
      allow(ids_service).to receive(:call).with(user: user).and_return([1, 2, 3])
      allow(repo).to receive(:by_ids).with([1, 2, 3]).and_return(from_api)
    end

    it 'returns from api offers' do
      expect(query).to eq(from_api)
    end

    context 'when user does not exist' do
      let(:user) { nil }

      it 'returns empty relation' do
        expect(query).to eq([])
      end
    end
  end
end
