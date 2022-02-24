# frozen_string_literal: true

# Roles and permissions created with this file

Role.create!(name: 'Peasant', permissions: %i[read write])
Role.create!(name: 'Moderator', permissions: %i[read write moderate])
Role.create!(name: 'Administrator', permissions: %i[read write moderate change_role])
Role.create!(name: 'Banned', permissions: %i[read])
