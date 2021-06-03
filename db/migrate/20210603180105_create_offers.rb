# frozen_string_literal: true

class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.integer :price, null: false
      t.string :company, null: false

      t.timestamps
    end
  end
end
