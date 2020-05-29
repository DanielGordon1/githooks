# frozen_string_literal: true

class Commit < ApplicationRecord
  validates :message, :sha, :committed_at, :ticket_identifiers,
            :repository_name, presence: true
  validates :sha, uniqueness: true

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :release, optional: true
end
