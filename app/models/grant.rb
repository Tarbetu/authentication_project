# frozen_string_literal: true

class Grant < ApplicationRecord
  has_and_belongs_to_many :role
end
