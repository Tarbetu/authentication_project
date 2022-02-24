# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users

  enummer permissions: %i[
    read
    write
    moderate
    change_role
  ]
end
