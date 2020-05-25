# frozen_string_literal: true

class Commit < ApplicationRecord
  validates :message, :sha, :committed_at, :ticket_identifiers,
            :repository_name, presence: true
  validates :sha, uniqueness: true

  belongs_to :user
  belongs_to :release
end
