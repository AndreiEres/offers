# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'offers', type: :request do
  describe 'GET /' do
    it 'returns status ok' do
      get '/offers'

      expect(response).to have_http_status(:ok)
    end

    it 'returns all offers' do
      offers = create_list(:offer, 3)

      get '/offers'

      expect(json_response).to eq(offers.map(&:as_json))
    end
  end
end
