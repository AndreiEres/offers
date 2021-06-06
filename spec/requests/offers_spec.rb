# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'offers', type: :request do
  describe 'GET /' do
    let(:result) do
      {
        'data' => [
          { 'company' => 'Apple', 'id' => 999, 'label' => 'perfect_match', 'price' => 999 },
          { 'company' => 'Apple', 'id' => 212, 'label' => 'good_match', 'price' => 212 },
          { 'company' => 'Amazon', 'id' => 412, 'label' => 'from_api', 'price' => 412 },
          { 'company' => 'Google', 'id' => 500, 'label' => 'offer', 'price' => 500 }
        ],
        'count' => 4,
        'items' => 4,
        'page' => 1,
        'pages' => 1
      }
    end

    before do
      create(:user, id: 100, company: 'Apple').tap do |user|
        user.departments << create(:department, name: 'IT')
      end

      create(:offer, id: 999, company: 'Apple', price: 999).tap do |perfect_match|
        perfect_match.departments << create(:department, name: 'IT')
      end

      create(:offer, id: 212, company: 'Apple', price: 212).tap do |good_match|
        good_match.departments << create(:department, name: 'Accounting')
      end

      create(:offer, id: 412, company: 'Amazon', price: 412, from_external_api: true)

      create(:offer, id: 500, company: 'Google', price: 500).tap do |offer|
        offer.departments << create(:department, name: 'Accounting')
      end
    end

    it 'returns offers' do
      get '/offers', params: { user_id: 100 }

      expect(json_response).to eq(result)
    end
  end
end
