# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfferLabel do
  describe '#call' do
    subject { described_class.new(id: id, ids: ids).to_s }

    let(:ids) { { right_label: [100, 200] } }

    context 'when id is in one of categories' do
      let(:id) { 100 }

      it { is_expected.to eq('right_label') }
    end

    context 'when id is out categories' do
      let(:id) { 101 }

      it { is_expected.to eq('') }
    end
  end
end
