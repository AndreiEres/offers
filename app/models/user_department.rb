# frozen_string_literal: true

class UserDepartment < ApplicationRecord
  belongs_to :user
  belongs_to :department
end
