# frozen_string_literal: true

Rails.application.routes.draw do
  # You might think that using resource only for index is strange.
  # This looks familiar and it's clear that what i'm doing to
  resource :greeters, only: %i[index]

  resource :users, only: %i[new create]
  resource :confirmations, only: %i[create edit new], param: :confirmation_token
end
