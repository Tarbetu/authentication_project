# frozen_string_literal: true

# Adding confirmation time and password digest
# Storing raw passwords are dangerous.
# You might want to read this (Turkish):
# https://fularsizentellik.com/journal/2018/5/12/internet-security-2-hashing
class AddConfirmationAndPasswordColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :confirmed_at, :datetime
    add_column :users, :password_digest, :string, null: false
  end
end
