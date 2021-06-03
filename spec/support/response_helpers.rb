# frozen_string_literal: true

module ResponseHelpers
  def json_response
    JSON.parse(response.body)
  end
end
