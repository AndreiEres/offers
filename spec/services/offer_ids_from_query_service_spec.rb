# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfferIdsFromQueryService do
  describe '#call' do
    subject { described_class.new(query).call(user: user) }

    let(:query) { instance_double(PerfectMatchOfferQuery) }
    let(:user) { instance_double(User) }
    let(:relation) { instance_double(ActiveRecord::Relation) }
    let(:result) { [100] }

    before do
      allow(query).to receive(:call).with(user: user).and_return(relation)
      allow(relation).to receive(:pluck).with(:id).and_return(result)
    end

    it { is_expected.to eq(result) }
  end
end
