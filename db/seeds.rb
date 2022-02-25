# frozen_string_literal: true

# Roles and grants created with this file

peasant = Role.create!(name: 'Peasant') # The first, id: 1
moderator = Role.create!(name: 'Moderator') # id: 2
admin = Role.create!(name: 'Administrator')
banned = Role.create!(name: 'Banned')

# Keep in mind, the grants name will used in methods name
read   = Grant.create!(name: 'read') # The first, id: 1
write  = Grant.create!(name: 'write') # id: 2
delete = Grant.create!(name: 'delete_and_edit_others')
manage = Grant.create!(name: 'manage_users')

banned.grants << read
banned.save!

peasant.grants << read
peasant.grants << write
peasant.save!

moderator.grants << read
moderator.grants << write
moderator.grants << delete
moderator.save!

admin.grants << read
admin.grants << write
admin.grants << delete
admin.grants << manage
admin.save!
