# frozen_string_literal: true

# Instead of creating a implict join table by has_and_belongs_to_many association,
# I prefer an explict model. So, the relationship can be managed by this file.
# Okay, this name is wrong. This is a true tongue slip.
# Anyway, this name is a real mistake. It should be renamed like "RoleGrant"
class RoleModelAssociation < ApplicationRecord
  belongs_to :role
  belongs_to :grant
end
