# frozen_string_literal: true

require 'rails_helper'
require 'external_api'

RSpec.describe ExternalApi do
  describe '#fetch_paginated_data' do
    subject do
      described_class
        .new(client)
        .fetch_paginated_data(path: path, data_attr: data_attr, pages_attr: pages_attr)
        .to_a
    end

    let(:client) { class_double(Faraday) }
    let(:path) { 'external_api_path' }
    let(:data_attr) { 'data' }
    let(:pages_attr) { 'pages' }
    let(:response) do
      instance_double(
        Faraday::Response,
        success?: true,
        body: { data: [{ 'item_id' => 1 }, { 'item_id' => 2 }], pages: 1 }.to_json
      )
    end

    before do
      allow(client).to receive(:get).with('external_api_path?page=1').and_return(response)
    end

    it { is_expected.to eq([{ 'item_id' => 1 }, { 'item_id' => 2 }]) }
  end
end
