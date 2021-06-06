# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfferIdsFromQueryService do
  describe '#call' do
    subject(:ids) { described_class.new(query).call(user: user, params: params) }

    let(:query) { instance_double(PerfectMatchOfferQuery) }
    let(:user) { instance_double(User) }
    let(:params) { {} }
    let(:relation) { class_double(Offer) }
    let(:result) { [100] }

    before do
      allow(query).to receive(:call).with(user: user).and_return(relation)
      allow(relation).to receive(:pluck).with(:id).and_return(result)
    end

    context 'without params' do
      it { is_expected.to eq(result) }
    end

    context 'with query param' do
      let(:params) { { query: 'ap' } }

      before do
        allow(relation).to receive(:company_like).and_return(relation)
      end

      it 'filters offers by company name' do
        ids

        expect(relation).to have_received(:company_like).with('ap')
      end
    end

    context 'with department_id param' do
      let(:params) { { department_id: [1] } }

      before do
        allow(relation).to receive(:by_department_ids).and_return(relation)
      end

      it 'filters offers by department_id' do
        ids

        expect(relation).to have_received(:by_department_ids).with([1])
      end
    end

    context 'with right sort param' do
      let(:params) { { sort: 'desc' } }

      before do
        allow(relation).to receive(:order).and_return(relation)
      end

      it 'sorts offers by price' do
        ids

        expect(relation).to have_received(:order).with(price: :desc)
      end
    end

    context 'with wrong sort param' do
      let(:params) { { sort: '_desc' } }

      before do
        allow(relation).to receive(:order).and_return(relation)
      end

      it 'sorts offers by price' do
        ids

        expect(relation).not_to have_received(:order)
      end
    end
  end
end
