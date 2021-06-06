# frozen_string_literal: true

class AddFieldsToOffers < ActiveRecord::Migration[6.1]
  def change
    add_column :offers, :public_id, :integer
    add_column :offers, :from_external_api, :boolean, default: false
  end
end
