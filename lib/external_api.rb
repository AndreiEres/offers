# frozen_string_literal: true

class ExternalApi
  attr_reader :client

  def initialize(client = Faraday)
    @client = client
  end

  def fetch_paginated_data(path:, data_attr: nil, pages_attr: nil) # rubocop:todo Metrics/MethodLength, Metrics/AbcSize
    Enumerator.new do |yielder|
      raise StopIteration unless data_attr || pages_attr

      page = 1

      loop do
        res = client.get("#{path}?page=#{page}")
        raise StopIteration unless res.success?

        json = JSON.parse(res.body)
        json[data_attr].map { |item| yielder << item }
        raise StopIteration if json[pages_attr] == page

        page += 1
      end
    end.lazy
  end
end
