# frozen_string_literal: true

# Instead of creating a implict join table by has_and_belongs_to_many association,
# I prefer an explict model. So, the relationship can be managed by this file.
class RoleModelAssociation < ApplicationRecord
  belongs_to :role
  belongs_to :grant
end
