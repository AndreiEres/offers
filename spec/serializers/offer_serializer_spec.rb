# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfferSerializer do
  describe '#as_json' do
    subject { described_class.new(offer, params).as_json }

    let(:offer) { build(:offer, id: 1, price: 100, company: 'Apple') }
    let(:params) { {} }
    let(:hash) do
      { 'id' => 1, 'price' => 100, 'company' => 'Apple', 'label' => '' }
    end

    it { is_expected.to eq(hash) }

    context 'when params for label passed' do
      let(:params) { { label: [1] } }
      let(:hash) do
        { 'id' => 1, 'price' => 100, 'company' => 'Apple', 'label' => 'label' }
      end

      it { is_expected.to eq(hash) }
    end
  end
end
