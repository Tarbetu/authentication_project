# frozen_string_literal: true

# Roles and grants created with this file

peasant = Role.create!(name: 'Peasant') # The first, id: 1
moderator = Role.create!(name: 'Moderator') # id: 2
admin = Role.create!(name: 'Administrator')
banned = Role.create!(name: 'Banned')

read   = Grant.create!(name: 'read') # The first, id: 1
write  = Grant.create!(name: 'write') # id: 2
delete = Grant.create!(name: 'delete_and_edit_others')
manage = Grant.create!(name: 'manage_users')

banned << read
banned.save!

peasant << read
peasant << write
peasant.save!

moderator << read
moderator << write
moderator << delete
moderator.save!

admin << read
admin << write
admin << delete
admin << manage
admin.save!
