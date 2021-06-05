# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfferSerializer do
  describe '#as_json' do
    subject { described_class.new(offer).as_json }

    let(:offer) { build(:offer, id: 1, price: 100, company: 'Apple') }
    let(:hash) do
      { 'id' => 1, 'price' => 100, 'company' => 'Apple' }
    end

    it { is_expected.to eq(hash) }
  end
end
