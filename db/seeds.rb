# frozen_string_literal: true

require 'csv'

CSV.foreach(Rails.root.join('db/seed_data/users.csv')) do |row|
  User.create(id: row[0], name: row[1], company: row[2])
end

CSV.foreach(Rails.root.join('db/seed_data/departments.csv')) do |row|
  Department.create(id: row[0], name: row[1])
end

CSV.foreach(Rails.root.join('db/seed_data/offers.csv')) do |row|
  Offer.create(id: row[0], price: row[1], company: row[2])
end

CSV.foreach(Rails.root.join('db/seed_data/offer_departments.csv')) do |row|
  OfferDepartment.create(id: row[0], offer_id: row[1], department_id: row[2])
end

CSV.foreach(Rails.root.join('db/seed_data/user_departments.csv')) do |row|
  UserDepartment.create(id: row[0], user_id: row[1], department_id: row[2])
end
